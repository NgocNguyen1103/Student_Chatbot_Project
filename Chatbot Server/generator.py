import numpy as np
import evaluate
import pandas as pd
from test_cases import test_cases
from gen_test_cases import gen_test_set
from langchain.embeddings import HuggingFaceEmbeddings
from langchain.vectorstores import Chroma
from langchain.memory import ConversationBufferMemory
from langchain.prompts import PromptTemplate
from langchain.chains import ConversationalRetrievalChain
from retriever import HybridRetriever
from transformers import AutoTokenizer, AutoModelForSeq2SeqLM, pipeline
from langchain.llms import HuggingFacePipeline
import collections

def token_f1(preds: list[str], refs: list[str]) -> float:
    f1_scores = []
    for p, r in zip(preds, refs):
        p_toks = p.split()
        r_toks = r.split()
        common = collections.Counter(p_toks) & collections.Counter(r_toks)
        tp = sum(common.values())
        prec = tp / len(p_toks) if p_toks else 0.0
        rec  = tp / len(r_toks) if r_toks else 0.0
        f1   = 2 * prec * rec / (prec + rec) if (prec + rec) > 0 else 0.0
        f1_scores.append(f1)
    return float(np.mean(f1_scores)) * 100
    
def evaluate_generator(chain, generation_cases):
    em    = evaluate.load("exact_match")
    rouge = evaluate.load("rouge")
    meteor= evaluate.load("meteor")

    preds, refs = [], []
    for case in generation_cases:
        q = case["query"]
        out = chain({"question": q})
        pred = out["answer"].strip()
        preds.append(pred)
        ref = case.get("answer") or case["gold_passages"][0]
        refs.append(ref.strip())

    # Exact Match
    # em_score = em.compute(predictions=preds, references=refs)["exact_match"] * 100
    rouge_res    = rouge.compute(predictions=preds, references=refs)
    rouge_l_f1   = rouge_res["rougeL"] * 100
    m  = meteor.compute(predictions=preds, references=refs)["meteor"] * 100
    f1_score  = token_f1(preds, refs)

    print(f"Generator ROUGE-L F1:  {rouge_l_f1:.2f}%")
    print(f"Generator METEOR:      {m:.2f}%")
    print(f"Token-F1:       {f1_score:.2f}%")


def build_conversation_chain(chat_history: list[tuple[str, str]]) -> ConversationalRetrievalChain:
    #persist_dir = "./chroma_db"
    persist_dir = "../chroma_db"
    embedding_model = HuggingFaceEmbeddings(model_name="sentence-transformers/all-mpnet-base-v2")
    vectorstore = Chroma(persist_directory=persist_dir, embedding_function=embedding_model)

    retriever = HybridRetriever(vectorstore, fetch_k=50, final_k=5)
    tokenizer = AutoTokenizer.from_pretrained("google/flan-t5-base", use_fast=True)
    model = AutoModelForSeq2SeqLM.from_pretrained("google/flan-t5-base")
    hf_pipe = pipeline(
        "text2text-generation",
        model=model,
        tokenizer=tokenizer,
        device=0,               # set to GPU
        max_new_tokens=256,

        temperature=0.2,
        
    )
    llm = HuggingFacePipeline(pipeline=hf_pipe)

    memory = ConversationBufferMemory(memory_key="chat_history", return_messages=True)
    for user_msg, bot_msg in chat_history:
        memory.chat_memory.add_user_message(user_msg)
        memory.chat_memory.add_ai_message(bot_msg)
    prompt = PromptTemplate(
        template=(
            '''You are a university assistant who answers questions based on the context provided.
    Use only information from the context to answer the question. If the context does not contain the answer, say, "I do not have enough information to answer that question."
    Context: {context}\n\nQuestion: {question}\n\nAnswer:'''
        ),
        input_variables=["context", "question"],
    )
    return ConversationalRetrievalChain.from_llm(
        llm=llm,
        retriever=retriever,
        memory=memory,
        combine_docs_chain_kwargs={"prompt": prompt},
    )

    # query = "What is the application fee for a candidate?"
    # response = chain.run(query)
    # print("Bot:", response)
    # print("\n=== Retrieval Evaluation ===")
    # metrics = evaluate_retrieval(retriever, gen_test_set, k=5)
    # print("Retrieval performance with HybridRetriever:")
    # for name, val in metrics.items():
    #     print(f" {name}: {val:.3f}")

    # print("\n=== Generation Evaluation ===")
    # evaluate_generator(chain, gen_test_set)

# if __name__ == "__main__":
#     main()
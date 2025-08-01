import os
from pathlib import Path
from langchain_community.document_loaders import PyPDFLoader
from langchain.text_splitter import RecursiveCharacterTextSplitter
from langchain.embeddings import HuggingFaceEmbeddings
from langchain.vectorstores import Chroma

def load_all_pdfs_from_folder(folder_path):
    pdf_files = list(Path(folder_path).rglob("*.pdf"))
    all_docs = []
    for pdf_file in pdf_files:
        loader = PyPDFLoader(str(pdf_file))
        docs = loader.load()
        all_docs.extend(docs)
    return all_docs


folder_path = "./data" 
documents = load_all_pdfs_from_folder(folder_path)
print(f"Loaded {len(documents)} documents")


text_splitter = RecursiveCharacterTextSplitter(chunk_size=1000, chunk_overlap=200, separators=["\n\n", "\n", ". ", " ", ""])
chunks = text_splitter.split_documents(documents)
print(f"Split into {len(chunks)} chunks")

embedding_model = HuggingFaceEmbeddings(model_name="sentence-transformers/all-mpnet-base-v2")
persist_dir = "../chroma_db"

if os.path.exists(persist_dir):
    Chroma(persist_directory=persist_dir, embedding_function=embedding_model).delete_collection()

vectorstore = Chroma.from_documents(chunks, embedding=embedding_model, persist_directory=persist_dir)
vectorstore.persist()

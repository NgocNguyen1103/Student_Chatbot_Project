
import os
import numpy as np
import pandas as pd
from rank_bm25 import BM25Okapi
from langchain.embeddings import HuggingFaceEmbeddings
from langchain.vectorstores import Chroma
from langchain.schema import BaseRetriever, Document
from sentence_transformers import CrossEncoder



class HybridRetriever(BaseRetriever):
    vs: Chroma
    bm25: BM25Okapi
    fetch_k: int
    final_k: int
    reranker: CrossEncoder

    class Config:
        arbitrary_types_allowed = True
        extra = "allow"

    def __init__(self, vs: Chroma, fetch_k: int = 50, final_k: int = 5):
        data = vs._collection.get(
            include=["documents", "metadatas"],
            limit=10_000
        )
        texts = data.get("documents", [])
        metadatas = data.get("metadatas", [])
        if not texts:
            raise ValueError(
                "Chroma collection is empty. "
            )
        docs = [Document(page_content=t, metadata=m) for t, m in zip(texts, metadatas)]
        tokenized_corpus = [doc.page_content.split() for doc in docs]
        bm25_index = BM25Okapi(tokenized_corpus)

        reranker = CrossEncoder("cross-encoder/ms-marco-MiniLM-L-12-v2")

        #Pydantic init
        super().__init__(
            vs=vs,
            bm25=bm25_index,
            fetch_k=fetch_k,
            final_k=final_k,
            reranker=reranker,
        )
        self._docs = docs

    def get_relevant_documents(self, query: str) -> list[Document]:
        # Sparse BM25 
        tokens = query.split()
        bm25_scores = self.bm25.get_scores(tokens)
        top_idx = np.argsort(bm25_scores)[::-1][: self.fetch_k]
        sparse_docs = [self._docs[i] for i in top_idx]

        # Dense embedding 
        dense_docs = self.vs.similarity_search(query, k=self.fetch_k)

        candidates_map = {
            doc.metadata.get("id", doc.page_content): doc
            for doc in sparse_docs + dense_docs
        }
        candidates = list(candidates_map.values())

        # Rerank 
        pairs = [[query, doc.page_content] for doc in candidates]
        scores = self.reranker.predict(pairs)
        ranked = sorted(zip(scores, candidates), key=lambda x: x[0], reverse=True)

        return [doc for _, doc in ranked[: self.final_k]]

    async def aget_relevant_documents(self, query: str) -> list[Document]:
        return self.get_relevant_documents(query)
from typing import List, Dict

def precision_at_k(retrieved: List[str], gold: List[str], k: int) -> float:
    topk = retrieved[:k]
    # Đếm xem mỗi doc trong top-k có match ít nhất 1 gold không
    hits = sum(
        1
        for doc in topk
        if any(g.lower() in doc.lower() for g in gold)
    )
    return hits / k if k else 0.0

def recall_at_k(retrieved: List[str], gold: List[str], k: int) -> float:
    topk = retrieved[:k]
    hits = sum(1 for g in gold if any(g.lower() in doc.lower() for doc in topk))
    return hits / len(gold)

def mrr_at_k(retrieved: List[str], gold: List[str], k: int) -> float:
    topk = retrieved[:k]
    for idx, doc in enumerate(topk, start=1):
        if any(g.lower() in doc.lower() for g in gold):
            return 1.0 / idx
    return 0.0

def evaluate_retrieval(retriever, test_cases: List[Dict], k: int = 5):
    precisions, recalls, mrrs = [], [], []
    for case in test_cases:
        query = case["query"]
        gold  = case["gold_passages"]
        docs  = retriever.get_relevant_documents(query)
        texts = [d.page_content for d in docs]
        precisions.append(precision_at_k(texts, gold, k))
        recalls.append   (recall_at_k   (texts, gold, k))
        mrrs.append      (mrr_at_k      (texts, gold, k))
    return {
        f"Precision@{k}": sum(precisions)/len(precisions),
        f"Recall@{k}"   : sum(recalls)   /len(recalls),
        f"MRR@{k}"      : sum(mrrs)      /len(mrrs),
    }



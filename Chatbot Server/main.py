from fastapi import FastAPI
from pydantic import BaseModel
from typing import List, Tuple
from generator import build_conversation_chain

app = FastAPI()

class RAGRequest(BaseModel):
    user_message: str
    chat_history: List[Tuple[str, str]]

@app.post("/rag_answer")
def rag_answer(req: RAGRequest):
    try:
        chain = build_conversation_chain(req.chat_history)
        answer = chain.run(req.user_message)
        print(answer)
        return {"answer": answer}
    except Exception as e:
        return {"answer": f"Error response: {str(e)}"}

@app.get('/')
def new_route():
    return "Hello"
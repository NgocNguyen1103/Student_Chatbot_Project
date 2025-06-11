from fastapi import FastAPI, Depends, HTTPException
from database import Base,engine
from models.users import Users
from routes.auth import router as auth_router  # Giả sử bạn đã định nghĩa router auth trong routes/auth.py
from routes.chat import router as chat_router
Base.metadata.create_all(bind=engine)
app = FastAPI(
    title="Basic FastAPI Project",
    version="1.0.0",
    description="Chatbot Backend API",
)

app.include_router(
    router=auth_router,  # Giả sử bạn đã định nghĩa router auth trong routes/auth.py
    prefix="/auth",      # Tiền tố cho các endpoint của auth
    tags=["auth"]       # Nhãn cho nhóm endpoint này
)

app.include_router(
    router = chat_router,
    prefix='/chat',
    tags=['chat']
)
# Endpoint gốc (tuỳ chọn)
@app.get("/", tags=["root"])
def read_root():
    return {"message": "Hello, this is the root endpoint"}

from pydantic import BaseModel
from typing import Optional
from datetime import datetime
import enum

class RoleEnum(str, enum.Enum):
    USER = "user"
    BOT = "bot"

class ChatStart(BaseModel):
    content: str

class ChatContinue(BaseModel):
    chat_session_id: int
    content: str
    

class ChatMessageOut(BaseModel):
    id: int
    chat_session_id: int
    sender: RoleEnum
    sequence_no: int
    content: str
    created_at: datetime

    class Config:
        from_attributes = True

class ChatSessionOut(BaseModel):
    id: int
    user_id: int
    title: Optional[str]
    created_at: datetime
    last_message: datetime

    class Config:
        from_attributes = True




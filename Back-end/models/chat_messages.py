from sqlalchemy import Column, Integer, String, ForeignKey, DateTime, func, Enum
import enum
from sqlalchemy.orm import relationship
from database import Base


class RoleEnum(enum.Enum):
    USER = "user"
    BOT = "chatbot"

class ChatMessages(Base):
    __tablename__ = "chat_messages"
    id = Column(Integer, primary_key=True, index=True)
    chat_session_id = Column(Integer, ForeignKey("chat_sessions.id"), nullable=False)
    sender = Column(Enum(RoleEnum), nullable=False, default=RoleEnum.USER)
    sequence_no = Column(Integer, nullable=False)
    content = Column(String, nullable=False)
    created_at = Column(DateTime, nullable=False, server_default=func.now())

    chat_session = relationship("ChatSessions", back_populates="chat_messages")
    def __repr__(self):
        return f"<ChatMessages(id={self.id}, chat_session_id={self.chat_session_id}, sender={self.sender}, sequence_no={self.sequence_no}, content={self.content})>"
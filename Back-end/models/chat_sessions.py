from database import Base
from sqlalchemy import Column, Integer, String, ForeignKey, DateTime, func
from sqlalchemy.orm import relationship

class ChatSessions(Base):
    __tablename__ = "chat_sessions"
    id = Column(Integer, primary_key = True, index= True)
    user_id = Column(Integer, ForeignKey("users.id"), nullable=False)
    title = Column(String, nullable=True)
    created_at = Column(DateTime, nullable=False, server_default=func.now())
    last_message = Column(DateTime, nullable=False, server_default=func.now(), onupdate=func.now())

    user = relationship("Users", back_populates="chat_sessions")
    chat_messages = relationship("ChatMessages", back_populates="chat_session", cascade="all, delete-orphan")
    def __repr__(self):
        return f"<ChatSessions(id={self.id}, user_id={self.user_id}, title={self.title})>"
from sqlalchemy import Column, Integer, String, Boolean, func
from database import Base
from sqlalchemy.orm import relationship

class Users(Base):
    __tablename__ =  "users"
    id = Column(Integer, primary_key=True, index=True)
    email = Column(String, unique=True, index=True, nullable=False)
    user_name = Column(String, unique=True, index=True, nullable=False)
    hashed_password = Column(String, nullable= False)
    google_id = Column(String, unique=True, index=True, nullable=True)
    created_at = Column(String, nullable=False, server_default=func.now())
    updated_at = Column(String, nullable=False, server_default=func.now(), onupdate=func.now())

    chat_sessions = relationship("ChatSessions", back_populates="user", cascade="all, delete-orphan")
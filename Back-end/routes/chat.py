from fastapi import APIRouter, Depends, status, HTTPException
from sqlalchemy.orm import Session
from database import get_db
from datetime import datetime
import schemas.chat_schema as SchemaChats
from models.users import Users as UserModels
from models.chat_sessions import ChatSessions
from models.chat_messages import ChatMessages, RoleEnum
import utils.security as Security
from typing import List
import requests
router = APIRouter()

def call_model_server(user_message: str, history: list[tuple[str, str]]) -> str:
    try:
        response = requests.post("http://localhost:8001/rag_answer", json={
            "user_message": user_message,
            "chat_history": history
        })
        return response.json()["answer"]
    except Exception as e:
        print(f"Error calling model server: {e}")
        return "Error connectting with chatbot model."

@router.post('/newchat', tags=['chat'], response_model=dict)
def start_chat(chat: SchemaChats.ChatStart, db: Session= Depends(get_db), current_user: UserModels = Depends(Security.get_current_user)):
    new_session = ChatSessions(user_id = current_user.id, title = chat.content)
    db.add(new_session)
    db.flush()

    first_message = ChatMessages(
        chat_session_id = new_session.id,
        sender = RoleEnum.USER,
        sequence_no = 1,
        content = chat.content
    )
    db.add(first_message)

    response =  call_model_server(chat.content, [])
    bot_message = ChatMessages(
        chat_session_id = new_session.id,
        sender = RoleEnum.BOT,
        sequence_no = 2,
        content = response
    )
    db.add(bot_message)
    new_session.last_message = datetime.now()

    db.commit()
    db.refresh(new_session)
    db.refresh(first_message)
    db.refresh(bot_message)
    return {
        "session": SchemaChats.ChatSessionOut.from_orm(new_session),
        "message": SchemaChats.ChatMessageOut.from_orm(bot_message)
    }


@router.post('/continue', tags=['chat'], response_model=SchemaChats.ChatMessageOut)
def continue_chat(chat: SchemaChats.ChatContinue, db: Session = Depends(get_db), current_user: UserModels = Depends(Security.get_current_user)):
    chat_session = (db.query(ChatSessions).filter(ChatSessions.id == chat.chat_session_id, UserModels.id == current_user.id).first())
    if not chat_session:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Session invalid or user invalid",
        )
    messages = db.query(ChatMessages).filter(ChatMessages.chat_session_id == chat.chat_session_id).order_by(ChatMessages.sequence_no.asc()).all()

    history = []
    temp = None
    for m in messages:
        if m.sender == RoleEnum.USER:
            temp = m.content
        elif m.sender == RoleEnum.BOT and temp:
            history.append((temp, m.content))
            temp = None

    last_message = messages[-1] if messages else None
    new_sequence_no = last_message.sequence_no + 1 if last_message else 1

    new_message = ChatMessages(
        chat_session_id = chat.chat_session_id,
        sender = RoleEnum.USER,
        sequence_no = new_sequence_no,
        content = chat.content
    )
    db.add(new_message)

    response = call_model_server(chat.content, history)
    bot_message = ChatMessages(
        chat_session_id = chat_session.id,
        sender = RoleEnum.BOT,
        sequence_no = new_sequence_no + 1,
        content = response
    )
    db.add(bot_message)
    chat_session.last_message = datetime.now()

    db.commit()
    db.refresh(bot_message)
    return bot_message


@router.get('/get_chat_sessions', tags=['chat'], response_model=List[SchemaChats.ChatSessionOut])
def get_sessions(db: Session = Depends(get_db), current_user: UserModels = Depends(Security.get_current_user)):
    try:

        chat_sessions = db.query(ChatSessions).filter(ChatSessions.user_id == current_user.id).all()

        
        print(chat_sessions)
        return chat_sessions
    except Exception as e:
        print(f"An error occurred: {e}")

        # Trả về thông báo lỗi chung cho người dùng
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail="An error occurred while fetching data"
        )
    

@router.get('/get_old_messages/{chat_session_id}', tags=['chat'], response_model=List[SchemaChats.ChatMessageOut])
def get_old_messages(chat_session_id: int,db: Session = Depends(get_db), current_user: UserModels = Depends(Security.get_current_user)):
    try:
        chat_session = (db.query(ChatSessions)
                        .filter(
                            ChatSessions.id == chat_session_id,
                            ChatSessions.user_id == current_user.id
                        )
                        .first())
        if not chat_session:
            raise HTTPException(
                status_code=status.HTTP_404_NOT_FOUND,
                detail="Chat session not found or you don't have access to it"
            )
        
        messages = (db.query(ChatMessages)
                    .filter(ChatMessages.chat_session_id == chat_session_id)
                    .order_by(ChatMessages.sequence_no)
                    .all())
        
        
        return messages
    except Exception as e:
        print(f"An error occurred: {e}")

        # Trả về thông báo lỗi chung cho người dùng
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail="An error occurred while fetching data"
        )



    



    



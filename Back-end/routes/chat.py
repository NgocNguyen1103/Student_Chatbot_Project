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

router = APIRouter(
    
)

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
    new_session.last_message = datetime.now()

    db.commit()
    db.refresh(new_session)
    db.refresh(first_message)
    return {
        "session": SchemaChats.ChatSessionOut.from_orm(new_session),
        "message": SchemaChats.ChatMessageOut.from_orm(first_message),
    }


@router.post('/continue', tags=['chat'], response_model=SchemaChats.ChatMessageOut)
def continue_chat(chat: SchemaChats.ChatContinue, db: Session = Depends(get_db), current_user: UserModels = Depends(Security.get_current_user)):
    chat_session = (db.query(ChatSessions).filter(ChatSessions.id == chat.chat_session_id, UserModels.id == current_user.id).first())
    if not chat_session:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Session invalid or user invalid",
        )
    last_message = (
        db.query(ChatMessages)
        .filter(
            ChatMessages.chat_session_id == chat.chat_session_id
        )
        .order_by(ChatMessages.sequence_no.desc())
        .first()
    )

    new_sequence_no = last_message.sequence_no + 1 if last_message else 1

    new_message = ChatMessages(
        chat_session_id = chat.chat_session_id,
        sender = RoleEnum.USER,
        sequence_no = new_sequence_no,
        content = chat.content
    )
    db.add(new_message)
    chat_session.last_message = datetime.now()

    db.commit()
    db.refresh(new_message)
    return new_message


@router.get('/get_chat_sessions', tags=['chat'], response_model=List[SchemaChats.ChatSessionOut])
def get_sessions(db: Session = Depends(get_db), current_user: UserModels = Depends(Security.get_current_user)):
    try:

        chat_sessions = db.query(ChatSessions).filter(ChatSessions.user_id == current_user.id).all()

        if not chat_sessions:
            return {"message": "No Chat Session  available"}
        
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
        
        if not messages:
            return {"message": "No message"}
        
        return messages
    except Exception as e:
        print(f"An error occurred: {e}")

        # Trả về thông báo lỗi chung cho người dùng
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail="An error occurred while fetching data"
        )



    



    



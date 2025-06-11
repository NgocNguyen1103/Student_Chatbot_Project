from fastapi import APIRouter, Depends, status, HTTPException
from sqlalchemy.orm import Session
from database import get_db
from datetime import datetime
import schemas.chat_schema as SchemaChats
from models.users import Users as UserModels
from models.chat_sessions import ChatSessions
from models.chat_messages import ChatMessages, RoleEnum
import utils.security as Security

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
    new_session.last_message = datetime.utcnow()

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

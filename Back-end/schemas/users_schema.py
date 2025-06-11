from pydantic import BaseModel, EmailStr
from typing import Optional

class UserCreate(BaseModel):
    user_name: str
    password: str
    email: EmailStr
    verify_password: str

class UserLogin(BaseModel):
    email: EmailStr
    password:str

class UserUpdate(BaseModel):
    user_name: Optional[str] = None
    email: Optional[EmailStr] = None
    password: Optional[str] = None
    verify_password: Optional[str] = None

    class Config:
        from_attributes = True
        extra = "forbid"  # Prevents additional fields not defined in the model
        
class GoogleLogin(BaseModel):
    token_id: str


class Token(BaseModel):
    access_token: str
    token_type: str = "bearer"

class UserOut(BaseModel):
    id: int
    user_name: str
    email: EmailStr
    
    class Config:
        from_attributes = True

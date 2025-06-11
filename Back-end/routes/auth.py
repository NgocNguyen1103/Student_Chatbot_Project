from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session
from database import get_db
import schemas.users_schema as SchemaUsers
from models.users import Users as ModelUsers
import utils.security as Security
router = APIRouter(
    tags=['auth']
)

@router.post("/signup")
def signUp(data: SchemaUsers.UserCreate, db: Session = Depends(get_db)):
    if db.query(ModelUsers).filter(ModelUsers.email == data.email).first():
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Email already registered"
        )
    if data.password != data.verify_password:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Passwords do not match"
        )
    hashed_password = Security.get_password_hash(data.password)
    new_user = ModelUsers(
        email=data.email,
        user_name=data.user_name,
        hashed_password=hashed_password
    )
    db.add(new_user)
    db.commit()
    db.refresh(new_user)
    return {"message": "User created successfully", "user_id": new_user.id}

@router.post('/login')
def login(data: SchemaUsers.UserLogin, db: Session = Depends(get_db)):
      user = db.query(ModelUsers).filter(ModelUsers.email == data.email).first()
      if not user or not Security.verify_password(data.password, user.hashed_password):
          raise HTTPException(
              status_code=status.HTTP_401_UNAUTHORIZED,
              detail="Invalid credentials"
          )
      access_token = Security.create_access_token(data={"user_id": user.id})
      return {"access_token": access_token, "token_type": "bearer"}

@router.get('/me', response_model=SchemaUsers.UserOut)
def read_me(current_user: ModelUsers = Depends(Security.get_current_user)):
    if not current_user:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Not authenticated"
        )
    return current_user

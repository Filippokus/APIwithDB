from fastapi import HTTPException
from sqlalchemy.orm import Session
from app.models import User
from app.schemas.user_schema import UserCreate, UserUpdate


def get_users(db: Session):
    return db.query(User).all()

def get_user(db: Session, user_id: int):
    return db.query(User).filter(User.userid == user_id).first()

def get_user_by_email(db: Session, email: str):
    return db.query(User).filter(User.email == email).first()

def get_user_by_id(db: Session, user_id: int):
    return db.query(User).filter(User.userid == user_id).first()

def create_user(db: Session, user: UserCreate):
    new_user = get_user_by_email(db, email=user.email)
    if new_user:
        raise HTTPException(status_code=400, detail="Email already registered")

    new_user = User(
        fullname=user.fullname,
        phone=user.phone,
        email=user.email,
        profession=user.profession,
        currentgamequestionid=user.currentgamequestionid
    )
    db.add(new_user)
    db.commit()
    db.refresh(new_user)
    return new_user

def update_user(db: Session, user_id: int, user: UserUpdate):
    up_user = get_user_by_id(db, user_id=user_id)
    if not up_user:
        raise HTTPException(status_code=404, detail="User not found")

    if user.email:
        existing_user = get_user_by_email(db, email=user.email)
        if existing_user and existing_user.userid != user_id:
            raise HTTPException(status_code=404, detail="Email already registered")
        
    for key, value in user.dict(exclude_unset=True).items():
        setattr(up_user, key, value)

    db.commit()
    db.refresh(up_user)
    return up_user

def delete_user(db: Session, user_id: int):
    del_user = get_user_by_id(db, user_id=user_id)
    if not del_user:
        raise HTTPException(status_code=404, detail="User not found")

    db.delete(del_user)
    db.commit()
    return del_user

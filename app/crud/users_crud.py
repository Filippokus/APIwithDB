from fastapi import HTTPException
from sqlalchemy.orm import Session
from app.models import User
from app.schemas.user_schema import UserCreate


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


def update_user_current_question(db: Session, user_id: int, current_question_id: int):
    user = db.query(User).filter(User.userid == user_id).first()
    if not user:
        raise HTTPException(status_code=404, detail="User not found")

    user.currentgamequestionid = current_question_id
    db.commit()
    db.refresh(user)
    return user

def delete_user(db: Session, user_id: int):
    del_user = get_user_by_id(db, user_id=user_id)
    if not del_user:
        raise HTTPException(status_code=404, detail="User not found")

    db.delete(del_user)
    db.commit()
    return del_user

from sqlalchemy.orm import Session
from app import schemas
from app.models import UserAnswer

def get_user_answers(db: Session):
    return db.query(UserAnswer).all()

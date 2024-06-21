from sqlalchemy.orm import Session
from fastapi import HTTPException

from app.models import UserAnswer
from app.schemas.user_game_answer_schema import UserAnswerCreate, ScoreResponse

def create_user_answer(db: Session, user_answer: UserAnswerCreate):

    #  Проверяем существует ли такая запись в БД
    existing_user_answer = db.query(UserAnswer).filter(
        UserAnswer.userid == user_answer.userid,
        UserAnswer.questionid == user_answer.questionid
    ).first()

    if existing_user_answer:
        raise HTTPException(status_code=400, detail="Answer for this user and question already exists.")

    db_user_answer = UserAnswer(
        userid=user_answer.userid,
        questionid=user_answer.questionid,
        score=user_answer.score
    )
    db.add(db_user_answer)
    db.commit()
    db.refresh(db_user_answer)
    return db_user_answer

def get_user_score(db: Session, userid: int, questionid: int):
    user_answer = db.query(UserAnswer).filter(
        UserAnswer.userid == userid,
        UserAnswer.questionid == questionid
    ).first()
    if user_answer:
        return ScoreResponse(score=user_answer.score)
    return None

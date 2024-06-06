from fastapi import HTTPException
from sqlalchemy.orm import Session
from app import schemas
from app.models import GameAnswer

def get_game_answers(db: Session):
    return db.query(GameAnswer).all()

def get_game_answer(db: Session, answer_id: int, question_id: int):
    return db.query(GameAnswer).filter(GameAnswer.questionid == question_id, GameAnswer.answerid == answer_id).first()

def get_game_answer_by_id(db: Session, answerid: int, questionid: int):
    return db.query(GameAnswer).filter(GameAnswer.answerid == answerid, GameAnswer.questionid == questionid).first()

def create_game_answer(db: Session, answer: schemas.GameAnswerCreate):
    existing_answer = get_game_answer_by_id(db, answer.answerid, answer.questionid)
    if existing_answer:
        raise HTTPException(status_code=400, detail="Answer with this ID and Question ID already exists")

    new_answer = GameAnswer(
        answerid=answer.answerid,
        questionid=answer.questionid,
        answertext=answer.answertext,
        score=answer.score
    )
    db.add(new_answer)
    db.commit()
    db.refresh(new_answer)
    return new_answer


def delete_game_answer(db: Session, answerid: int, questionid: int):
    answer = get_game_answer_by_id(db, answerid, questionid)
    if not answer:
        raise HTTPException(status_code=404, detail="Answer not found")

    db.delete(answer)
    db.commit()
    return answer

def delete_all_answers_for_question(db: Session, questionid: int):
    num_deleted = db.query(GameAnswer).filter(GameAnswer.questionid == questionid).delete()
    db.commit()
    return num_deleted
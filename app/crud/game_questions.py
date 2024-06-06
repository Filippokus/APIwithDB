from fastapi import HTTPException
from sqlalchemy.orm import Session
from app import schemas
from app.models import GameQuestion


def get_game_question(db: Session, question_id: int):
    return db.query(GameQuestion).filter(GameQuestion.questionid == question_id).first()


def get_game_questions(db: Session):
    return db.query(GameQuestion).all()


def get_game_question_by_id(db: Session, questionid: int):
    return db.query(GameQuestion).filter(GameQuestion.questionid == questionid).first()


def create_game_question(db: Session, question: schemas.GameQuestionCreate):
    new_question = GameQuestion(
        questiontext=question.questiontext
    )
    db.add(new_question)
    db.commit()
    db.refresh(new_question)
    return new_question

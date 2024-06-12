from typing import List

from fastapi import HTTPException
from sqlalchemy.orm import Session
from app import schemas
from app.crud.game_answers import delete_all_answers_for_question
from app.models import GameQuestion
from app.schemas import GameQuestionCreate


def get_game_question(db: Session, question_id: int):
    return db.query(GameQuestion).filter(GameQuestion.questionid == question_id).first()


def get_game_questions(db: Session):
    return db.query(GameQuestion).all()


def get_game_question_by_id(db: Session, questionid: int):
    return db.query(GameQuestion).filter(GameQuestion.questionid == questionid).first()

def get_existing_questions(db: Session, questions: List[GameQuestionCreate]):
    question_texts = [question.question_text for question in questions]
    existing_questions = db.query(GameQuestion).filter(GameQuestion.questiontext.in_(question_texts)).all()
    return set(question.question_text for question in existing_questions)

def create_game_question(db: Session, question: schemas.GameQuestionCreate):
    new_question = GameQuestion(
        questiontext=question.questiontext
    )
    db.add(new_question)
    db.commit()
    db.refresh(new_question)
    return new_question

def create_multiple_game_questions(db: Session, questions: List[GameQuestionCreate]):
    existing_questions_set = get_existing_questions(db, questions)

    new_questions = []
    for question in questions:
        if question.question_text not in existing_questions_set:
            new_question = GameQuestion(questiontext=question.question_text)
            new_questions.append(new_question)

    if new_questions:
        db.add_all(new_questions)
        db.commit()

    return new_questions

def delete_game_question(db: Session, questionid: int):
    question = get_game_question_by_id(db, questionid)
    if not question:
        raise HTTPException(status_code=404, detail="Question not found")
    db.delete(question)
    db.commit()
    return question

from typing import List

from fastapi import HTTPException
from sqlalchemy.orm import Session
from sqlalchemy import text

from app.models import GameQuestion
from app.schemas.game_question_schema import GameQuestionCreate

def get_game_question(db: Session, question_id: int):
    return db.query(GameQuestion).filter(GameQuestion.questionid == question_id).first()


def get_game_questions(db: Session):
    return db.query(GameQuestion).all()


def get_game_question_by_id(db: Session, questionid: int):
    return db.query(GameQuestion).filter(GameQuestion.questionid == questionid).first()

def get_existing_questions(db: Session, questions: List[GameQuestionCreate]):
    question_texts = [question.questiontext for question in questions]
    existing_questions = db.query(GameQuestion).filter(GameQuestion.questiontext.in_(question_texts)).all()
    return set(question.questiontext for question in existing_questions)

def create_game_question(db: Session, question: GameQuestionCreate):
    new_question = GameQuestion(
        questiontext=question.questiontext,
        chapter=question.chapter
    )
    db.add(new_question)
    db.commit()
    db.refresh(new_question)
    return new_question


def reset_questionid_sequence(db: Session):
    reset_sequence_query = text("ALTER SEQUENCE petsitters.gamequestion_questionid_seq RESTART WITH 1;")
    db.execute(reset_sequence_query)
    db.commit()


def create_multiple_game_questions(db: Session, questions: List[GameQuestionCreate]):
    # Проверка, если таблица пустая
    if not db.query(GameQuestion).count():
        reset_questionid_sequence(db)

    existing_questions_set = get_existing_questions(db, questions)

    new_questions = []
    for question in questions:
        if question.questiontext not in existing_questions_set:
            new_question = GameQuestion(
                questiontext=question.questiontext,
                chapter=question.chapter
            )
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

def questions_by_chapter(db: Session, chapter: str):
    questions = db.query(GameQuestion).filter(GameQuestion.chapter == chapter).all()
    if not questions:
        raise HTTPException(status_code=404, detail=f"Questions with chapter '{chapter}' not found")
    return questions

from typing import List

from fastapi import HTTPException
from sqlalchemy.orm import Session

from app.models import GameAnswer
from app.schemas.game_answer_schema import GameAnswerCreate

def get_game_answers(db: Session):
    return db.query(GameAnswer).all()

def get_game_answer(db: Session, answer_id: int, question_id: int):
    return db.query(GameAnswer).filter(GameAnswer.questionid == question_id, GameAnswer.answerid == answer_id).first()

def get_game_answer_by_id(db: Session, answerid: int, questionid: int):
    return db.query(GameAnswer).filter(GameAnswer.answerid == answerid, GameAnswer.questionid == questionid).first()


#  Получаем правильные ответы и возвращаем словарь
def get_correct_answers(db: Session, questionid: int):
    correct_answers = db.query(GameAnswer).filter(GameAnswer.questionid == questionid).all()
    return {answer.answerid: answer.is_correct for answer in correct_answers}


def get_existing_answers(db: Session, answers: List[GameAnswerCreate]) -> set:
    answer_ids = [answer.answerid for answer in answers]
    question_ids = [answer.questionid for answer in answers]

    existing_answers = db.query(GameAnswer).filter(
        (GameAnswer.answerid.in_(answer_ids)) &
        (GameAnswer.questionid.in_(question_ids))
    ).all()

    existing_answers_set = {(answer.answerid, answer.questionid) for answer in existing_answers}
    return existing_answers_set

def create_game_answer(db: Session, answer: GameAnswerCreate):
    from app.crud.game_questions_crud import get_game_question_by_id
    
    if not get_game_question_by_id(db, questionid=answer.questionid):
        raise HTTPException(status_code=404, detail="Question not found")

    existing_answer = get_game_answer_by_id(db, answer.answerid, answer.questionid)
    if existing_answer:
        raise HTTPException(status_code=400, detail="Answer with this ID and Question ID already exists")

    new_answer = GameAnswer(
        answerid=answer.answerid,
        questionid=answer.questionid,
        answertext=answer.answertext,
        is_correct=answer.is_correct
    )
    db.add(new_answer)
    db.commit()
    db.refresh(new_answer)
    return new_answer


def create_multiple_game_answers(db: Session, answers: List[GameAnswerCreate]):
    existing_answers_set = get_existing_answers(db, answers)

    new_answers = []
    for answer in answers:
        if (answer.answerid, answer.questionid) not in existing_answers_set:
            try:
                new_answer = create_game_answer(db, answer)
                new_answers.append(new_answer)
            except HTTPException as e:
                if e.status_code == 404:
                    # Handle the case where the question was not found
                    print(f"Question with ID {answer.questionid} not found.")
                elif e.status_code == 400:
                    # Handle the case where the answer already exists
                    print(f"Answer with ID {answer.answerid} for question {answer.questionid} already exists.")
                else:
                    # Handle other HTTP exceptions
                    print(f"HTTP Exception occurred: {e.detail}")
                continue
            except Exception as e:
                # Handle any other unexpected exceptions
                print(f"An unexpected error occurred: {str(e)}")
                continue

    return new_answers


def delete_game_answer(db: Session, answerid: int, questionid: int):
    answer = get_game_answer_by_id(db, answerid, questionid)
    if not answer:
        raise HTTPException(status_code=404, detail="Answer not found")

    db.delete(answer)
    db.commit()
    return answer

def delete_all_answers_for_question(db: Session, questionid: int):
    num_deleted = (db.query(GameAnswer).filter(GameAnswer.questionid == questionid)).delete()
    db.commit()
    return num_deleted

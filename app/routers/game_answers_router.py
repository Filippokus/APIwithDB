import json
from typing import List

from fastapi import APIRouter, Depends, HTTPException, UploadFile, File
from sqlalchemy.orm import Session

from app.database import get_db

from app.crud.game_answers_crud import get_game_answer, get_game_answers, create_game_answer, delete_game_answer, \
    delete_all_answers_for_question, create_multiple_game_answers

from app.schemas.game_answer_schema import GameAnswer, GameAnswerCreate, GameAnswersCreate

router = APIRouter(tags=["Game Answers"])


"""GET"""


@router.get("/answers/", response_model=list[GameAnswer])
def read_game_answers(db: Session = Depends(get_db)):
    """
    Получить список всех ответов.
    """
    game_answers = get_game_answers(db)
    return game_answers


@router.get("/answer/{answer_id}_{question_id}/", response_model=GameAnswer)
def read_game_answer(answer_id: int, question_id: int, db: Session = Depends(get_db)):
    """
    Получить ответ по идентификаторам вопроса и ответа.
    """
    answer = get_game_answer(db, answer_id=answer_id, question_id=question_id)
    if answer is None:
        raise HTTPException(status_code=404, detail="Answer not found")
    return answer


"""POST"""


@router.post("/add_answer/", response_model=GameAnswer)
def create_game_answer_endpoint(answer: GameAnswerCreate, db: Session = Depends(get_db)):
    """
    Добавить новый ответ для конкретного вопроса игры.
    """
    return create_game_answer(db, answer=answer)


@router.post("/add_answers_from_file/", response_model=List[GameAnswerCreate])
async def add_answers_from_file(file: UploadFile = File(...), db: Session = Depends(get_db)):
    """
    Загрузить все ответы в базу данных из файла
    """
    try:
        file_content = await file.read()
        answers_data = json.loads(file_content)
        answers_schema = GameAnswersCreate(**answers_data)
    except Exception:
        raise HTTPException(status_code=400, detail="Invalid JSON file")

    answers = create_multiple_game_answers(db, answers_schema.answers)
    return answers


"""DELETE"""


@router.delete("/delete_answer/{answerid}/{questionid}/", response_model=GameAnswer)
def delete_game_answer_endpoint(answer_id: int, question_id: int, db: Session = Depends(get_db)):
    """
    Удалить ответ по его идентификатору и идентификатору вопроса.
    """
    return delete_game_answer(db, answer_id, question_id)


@router.delete("/delete_all_answers/{questionid}/", response_model=int)
def delete_all_answers_for_question_endpoint(question_id: int, db: Session = Depends(get_db)):
    """
    Удалить все ответы для конкретного вопроса.
    """
    return delete_all_answers_for_question(db, question_id)

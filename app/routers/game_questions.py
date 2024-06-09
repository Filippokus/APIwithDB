import json
from typing import List

from fastapi import APIRouter, Depends, HTTPException, UploadFile, File
from sqlalchemy.orm import Session
from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from app import schemas
from app.database import get_db
from app.crud.game_questions import get_game_questions, get_game_question, create_game_question, create_multiple_game_questions
from app.schemas import GameQuestionsCreate

router = APIRouter(tags=["Game Questions"])

"""GET"""


@router.get("/questions/", response_model=list[schemas.GameQuestion])
def read_game_all_questions(db: Session = Depends(get_db)):
    """
    Получить список всех вопросов игры.
    """
    game_questions = get_game_questions(db)
    if game_questions is None:
        raise HTTPException(status_code=404, detail="Questions not found")
    return game_questions


@router.get("/question/{question_id}/", response_model=schemas.GameQuestion)
def read_game_question(question_id: int, db: Session = Depends(get_db)):
    """
    Получить конкретный вопрос игры по его идентификатору.
    """
    question = get_game_question(db, question_id=question_id)
    if question is None:
        raise HTTPException(status_code=404, detail="Question not found")
    return question


@router.get("/questiondetail/{question_id}/", response_model=schemas.GameQuestionDetail)
def read_game_detail_question(question_id: int, db: Session = Depends(get_db)):
    """
    Получить подробную информацию о конкретном вопросе игры по его идентификатору.
    """
    question_detail = get_game_question(db, question_id=question_id)
    if question_detail is None:
        raise HTTPException(status_code=404, detail="Question not found")
    return question_detail


"""POST"""


@router.post("/add_question/", response_model=schemas.GameQuestion)
def create_game_question_endpoint(question: schemas.GameQuestionCreate, db: Session = Depends(get_db)):
    """
        Создать новый вопрос для игры.
    """
    return create_game_question(db, question=question)

@router.post("/add_questions/", response_model=List[schemas.GameQuestionCreate])
async def add_questions_from_file(file: UploadFile = File(...), db: Session = Depends(get_db)):
    """
    Загрузить все вопросы в базу данных из файла
    """
    try:
        file_content = await file.read()
        questions_data = json.loads(file_content)
        question_schema = GameQuestionsCreate(**questions_data)
    except Exception:
        raise HTTPException(status_code=400, detail="Invalid JSON file")

    questions = create_multiple_game_questions(db, question_schema.questions)
    return questions

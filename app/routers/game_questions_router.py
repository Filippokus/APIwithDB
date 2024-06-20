import json
from typing import List
from fastapi import APIRouter, Depends, HTTPException, UploadFile, File
from sqlalchemy.orm import Session

from app.database import get_db
from app.crud.game_questions_crud import (get_game_questions, get_game_question,
                                          create_game_question, create_multiple_game_questions,
                                          delete_game_question, questions_by_chapter)
from app.crud.game_answers_crud import delete_all_answers_for_question
from app.schemas.game_question_schema import GameQuestion, GameQuestionDetail, GameQuestionCreate, GameQuestionsCreate

router = APIRouter(tags=["Game Questions"])


"""GET"""


@router.get("/questions/", response_model=list[GameQuestion])
def read_game_all_questions(db: Session = Depends(get_db)):
    """
    Получить список всех вопросов игры.
    """
    game_questions = get_game_questions(db)
    if game_questions is None:
        raise HTTPException(status_code=404, detail="Questions not found")
    return game_questions


@router.get("/question/{question_id}/", response_model=GameQuestion)
def read_game_question(question_id: int, db: Session = Depends(get_db)):
    """
    Получить конкретный вопрос игры по его идентификатору.
    """
    question = get_game_question(db, question_id=question_id)
    if question is None:
        raise HTTPException(status_code=404, detail="Question not found")
    return question


@router.get("/questiondetail/{question_id}/", response_model=GameQuestionDetail)
def read_game_detail_question(question_id: int, db: Session = Depends(get_db)):
    """
    Получить подробную информацию о конкретном вопросе игры по его идентификатору.
    """
    question_detail = get_game_question(db, question_id=question_id)
    if question_detail is None:
        raise HTTPException(status_code=404, detail="Question not found")
    return question_detail


@router.get("/questions/chapter/{chapter}", response_model=List[GameQuestionDetail])
def get_questions_by_chapter(chapter: str, db: Session = Depends(get_db)):
    """
    Получить все вопросы для указанной главы.
    """
    return questions_by_chapter(db, chapter)


"""POST"""


@router.post("/add_question/", response_model=GameQuestion)
def create_game_question_endpoint(question: GameQuestionCreate, db: Session = Depends(get_db)):
    """
        Создать новый вопрос для игры.
    """
    return create_game_question(db, question=question)

@router.post("/add_questions/", response_model=List[GameQuestionCreate])
async def add_questions_from_file(file: UploadFile = File(...), db: Session = Depends(get_db)):
    """
    Загрузить все вопросы в базу данных из файла
    """
    try:
        file_content = await file.read()
        questions_data = json.loads(file_content)
        question_schema = GameQuestionsCreate(**questions_data)
    except Exception as e:
        raise HTTPException(status_code=400, detail=f"Invalid JSON file: {str(e)}")

    questions = create_multiple_game_questions(db, questions=question_schema.questions)
    return questions


"""DELETE"""


@router.delete("delete_question/{questionid}", response_model=GameQuestion)
def delete_game_question_endpoint(question_id: int, db: Session = Depends(get_db)):
    """
    Удалить вопрос по его идентификатору
    """
    delete_all_answers_for_question(db, question_id)
    return delete_game_question(db, question_id)

from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from app import schemas
from app.database import get_db
from app.crud.game_questions import get_game_questions, get_game_question, create_game_question

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

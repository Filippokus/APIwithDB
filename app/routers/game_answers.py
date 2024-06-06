from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session

from app import schemas
from app.database import get_db
from app.crud.game_answers import get_game_answer, get_game_answers, create_game_answer, delete_game_answer, delete_all_answers_for_question

router = APIRouter(tags=["Game Answers"])


"""GET"""


@router.get("/answers/", response_model=list[schemas.GameAnswer])
def read_game_answers(db: Session = Depends(get_db)):
    """
    Получить список всех ответов.
    """
    game_answers = get_game_answers(db)
    return game_answers


@router.get("/answer/{answer_id}_{question_id}/", response_model=schemas.GameAnswer)
def read_game_answer(answer_id: int, question_id: int, db: Session = Depends(get_db)):
    """
    Получить ответ по идентификаторам вопроса и ответа.
    """
    answer = get_game_answer(db, answer_id=answer_id, question_id=question_id)
    if answer is None:
        raise HTTPException(status_code=404, detail="Answer not found")
    return answer


"""POST"""


@router.post("/add_answer/", response_model=schemas.GameAnswer)
def create_game_answer_endpoint(answer: schemas.GameAnswerCreate, db: Session = Depends(get_db)):
    """
    Добавить новый ответ для конкретного вопроса игры.
    """
    return create_game_answer(db, answer=answer)


"""DELETE"""


@router.delete("/delete_answer/{answerid}/{questionid}/", response_model=schemas.GameAnswer)
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
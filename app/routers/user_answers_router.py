from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session

from app.crud.game_answers_crud import get_correct_answers
from app.models import User, GameQuestion, GameAnswer, UserAnswer

from app.schemas.user_game_answer_schema import UserAnswerList, ScoreResponse
from app.crud.user_answers_crud import create_user_answer, get_user_score
from app.database import get_db


router = APIRouter(tags=["User Answers"])


@router.post("/submit_answers/", response_model=ScoreResponse)
def submit_answers(user_answers: UserAnswerList, db: Session = Depends(get_db)):
    """
    Принимает список ответов на один вопрос, сравнивает с правильными ответами и записывает результат.
    """
    # Проверка существования пользователя
    user = db.query(User).filter(User.userid == user_answers.userid).first()
    if not user:
        raise HTTPException(status_code=404, detail="User not found")

    # Проверка существования вопроса
    question = db.query(GameQuestion).filter(GameQuestion.questionid == user_answers.questionid).first()
    if not question:
        raise HTTPException(status_code=404, detail="Question not found")

    # Проверка существования всех ответов для вопроса
    expected_answers = db.query(GameAnswer).filter(GameAnswer.questionid == user_answers.questionid).all()
    if not expected_answers:
        raise HTTPException(status_code=404, detail="No answers found for the given question")

    expected_answer_ids = {answer.answerid for answer in expected_answers}
    received_answer_ids = {answer.answerid for answer in user_answers.answers}

    if received_answer_ids != expected_answer_ids:
        raise HTTPException(status_code=400,
                            detail="Provided answers do not match the expected answers for the question")

    # Проверка существования каждого ответа
    for answer in user_answers.answers:
        db_answer = db.query(GameAnswer).filter(
            GameAnswer.answerid == answer.answerid,
            GameAnswer.questionid == answer.questionid
        ).first()
        if not db_answer:
            raise HTTPException(status_code=404,
                                detail=f"Answer with answerid {answer.answerid} "
                                       f"and questionid {answer.questionid} not found")

    # Получаем правильные ответы
    correct_answers_dict = get_correct_answers(db, user_answers.questionid)

    # Сравниваем ответы пользователя с правильными ответами
    all_correct = all(
        answer.is_correct == correct_answers_dict.get(answer.answerid, False)
        for answer in user_answers.answers
    )

    # Ставим значение 1, если ответ правильный, иначе 0
    score = 1 if all_correct else 0

    # Создаем запись UserAnswer
    if create_user_answer(
        db,
        UserAnswer
        (
            userid=user_answers.userid,
            questionid=user_answers.questionid,
            score=score
        )
    ):
        return {"score": score}


@router.get("/score_answers/{userid}/{questionid}", response_model=ScoreResponse)
def get_score(userid: int, questionid: int, db: Session = Depends(get_db)):
    user_answer = get_user_score(db, userid, questionid)
    if not user_answer:
        raise HTTPException(status_code=404, detail="Answer not found")
    return user_answer
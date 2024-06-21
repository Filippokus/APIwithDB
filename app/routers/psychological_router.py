from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session

from app.crud.psychology_crud import analyze_responses
from app.database import get_db
from app.models import User, UserTestResult
from app.schemas.psychology_answers_schema import ResponseData

router = APIRouter(tags=["Psychological Questions"])


@router.post("/send_psycho_answers/")
def analyze(data: ResponseData, db: Session = Depends(get_db)):
    user = db.query(User).filter(User.userid == data.userid).first()
    if not user:
        raise HTTPException(status_code=404, detail="User not found")
    result = analyze_responses(data)

    test_result = UserTestResult(
        userid=data.userid,
        temperament=result['psyresult']['temperament'],
        extraversion_result=result['psyresult']['extraversion_result'],
        neuroticism_result=result['psyresult']['neuroticism_result'],
        lie_result=result['psyresult']['lie_result']
    )

    db.add(test_result)
    db.commit()

    return result

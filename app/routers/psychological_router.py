from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session

from app.crud.psychology import analyze_responses
from app.database import get_db
from app.models import User
from app.schemas.pshylogic_answers import ResponseData

router = APIRouter(tags=["Psychological Questions"])


@router.post("/send_psycho_answers/")
def analyze(data: ResponseData, db: Session = Depends(get_db)):
    user = db.query(User).filter(User.userid == data.userid).first()
    if not user:
        raise HTTPException(status_code=404, detail="User not found")
    result = analyze_responses(data)
    return result

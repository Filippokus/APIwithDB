
from app.schemas.base_schema import BaseModelGame


class UserAnswer(BaseModelGame):
    userid: int
    questionid: int
    answertext: str
    score: int

from typing import List

from app.schemas.base_schema import BaseModelGame

class GameAnswer(BaseModelGame):
    answerid: int
    questionid: int
    answertext: str
    is_correct: bool


class GameAnswerInList(BaseModelGame):
    answerid: int
    questionid: int
    is_correct: bool


class GameAnswerCreate(BaseModelGame):
    answerid: int
    questionid: int
    answertext: str
    is_correct: bool


class GameAnswersCreate(BaseModelGame):
    answers: List[GameAnswerCreate]

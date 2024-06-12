from typing import Optional, List

from pydantic import BaseModel, EmailStr

class BaseModelGame(BaseModel):
    class Config:
        from_attributes = True
class GameAnswer(BaseModelGame):
    answerid: int
    questionid: int
    answertext: str
    is_correct: bool


class GameAnswerCreate(BaseModelGame):
    answerid: int
    questionid: int
    answertext: str
    is_correct: bool


class GameAnswersCreate(BaseModelGame):
    answers: List[GameAnswerCreate]

class GameQuestion(BaseModelGame):
    questionid: int
    questiontext: str
    chapter: str


class GameQuestionDetail(GameQuestion):
    answers: Optional[List[GameAnswer]] = []


class GameQuestionCreate(BaseModel):
    questiontext: str
    chapter: str


class GameQuestionsCreate(BaseModelGame):
    questions: List[GameQuestionCreate]


class UserAnswer(BaseModelGame):
    userid: int
    questionid: int
    answertext: str
    score: int


class User(BaseModelGame):
    userid: int
    fullname: str
    phone: str
    email: str
    profession: str
    currentgamequestionid: Optional[int]


class UserCreate(BaseModelGame):
    fullname: str
    phone: str
    email: EmailStr
    profession: str
    currentgamequestionid: Optional[int]


class UserUpdate(BaseModelGame):
    fullname: str
    phone: str
    email: EmailStr
    profession: str
    currentgamequestionid: Optional[int]

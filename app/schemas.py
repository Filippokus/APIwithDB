from typing import Optional, List

from pydantic import BaseModel, EmailStr


class GameAnswer(BaseModel):
    answerid: int
    questionid: int
    answertext: str
    score: float

    class Config:
        from_attributes = True


class GameAnswerCreate(BaseModel):
    answerid: int
    questionid: int
    answertext: str
    score: float
    
    class Config:
        from_attributes = True

class GameQuestion(BaseModel):
    questionid: int
    questiontext: str

    class Config:
        from_attributes = True

class GameQuestionDetail(GameQuestion):
    answers: Optional[List[GameAnswer]] = []

    class Config:
        from_attributes = True


class GameQuestionCreate(BaseModel):
    questiontext: str

    class Config:
        from_attributes = True


class UserAnswer(BaseModel):
    userid: int
    questionid: int
    answertext: str
    score: float

    class Config:
        from_attributes = True


class User(BaseModel):
    userid: int
    fullname: str
    phone: str
    email: str
    profession: str
    currentgamequestionid: Optional[int]

    class Config:
        from_attributes = True


class UserCreate(BaseModel):
    fullname: str
    phone: str
    email: EmailStr
    profession: str
    currentgamequestionid: Optional[int]

    class Config:
        from_attributes = True

class UserUpdate(BaseModel):
    fullname: str
    phone: str
    email: EmailStr
    profession: str
    currentgamequestionid: Optional[int]

    class Config:
        from_attributes = True




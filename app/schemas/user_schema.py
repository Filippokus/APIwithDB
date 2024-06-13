from typing import Optional
from pydantic import EmailStr

from app.schemas.base_schema import BaseModelGame

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

class UserUpdateCurrentQuestion(BaseModelGame):
    currentgamequestionid: Optional[int]



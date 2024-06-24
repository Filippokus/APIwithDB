from typing import List

from .base_schema import BaseModelGame
from .game_answer_schema import GameAnswerInList


class UserAnswerCreate(BaseModelGame):
    userid: int
    questionid: int
    score: int

class UserAnswerList(BaseModelGame):
    userid: int
    questionid: int
    answers: List[GameAnswerInList]

class ScoreResponse(BaseModelGame):
    score: int

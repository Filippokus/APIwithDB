from typing import Optional, List

from .base_schema import BaseModelGame
from .game_answer_schema import GameAnswer

class GameQuestion(BaseModelGame):
    questionid: int
    questiontext: str
    chapter: str


class GameQuestionDetail(GameQuestion):
    answers: Optional[List[GameAnswer]] = []


class GameQuestionCreate(BaseModelGame):
    questiontext: str
    chapter: str


class GameQuestionsCreate(BaseModelGame):
    questions: List[GameQuestionCreate]

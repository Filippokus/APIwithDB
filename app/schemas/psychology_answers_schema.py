from typing import List

from app.schemas.base_schema import BaseModelGame

class ResponseData(BaseModelGame):
    userid: int
    psyresult: List[int]


class UserTestResultSchema(BaseModelGame):
    userid: int
    temperament: str
    extraversion_result: str
    neuroticism_result: str
    lie_result: str
    
from typing import List

from app.schemas.base_schema import BaseModelGame

class ResponseData(BaseModelGame):
    userid: int
    psyresult: List[int]
    
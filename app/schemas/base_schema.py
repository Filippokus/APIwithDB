from pydantic import BaseModel

class BaseModelGame(BaseModel):
    class Config:
        from_attributes = True

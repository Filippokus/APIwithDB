from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session

from app import schemas
from app.database import get_db
from app.crud import users

router = APIRouter(tags=["Users"])

"""GET"""


@router.get("/users/", response_model=list[schemas.User])
def read_users(db: Session = Depends(get_db)):
    """
    Получить список всех пользователей.
    """
    all_users = users.get_users(db)
    return all_users


@router.get("/user/{user_id}", response_model=schemas.User)
def read_user(user_id: int, db: Session = Depends(get_db)):
    """
    Получить конкретного пользователя по его идентификатору.
    """
    user = users.get_user(db, user_id=user_id)
    if user is None:
        raise HTTPException(status_code=404, detail="User not found")
    return user


"""POST"""


@router.post("/add_user/", response_model=schemas.User)
def create_user(user: schemas.UserCreate, db: Session = Depends(get_db)):
    """
    Создать нового пользователя.
    """
    new_user = users.create_user(db, user=user)
    return new_user


"""PUT"""


@router.put("/users/{user_id}", response_model=schemas.User)
def update_user(user_id: int, user: schemas.UserUpdate, db: Session = Depends(get_db)):
    """
    Обновить информацию о пользователе.
    """
    return users.update_user(db, user_id=user_id, user=user)


"""DELETE"""


@router.delete("/users/{user_id}", response_model=schemas.User)
def delete_user(user_id: int, db: Session = Depends(get_db)):
    """
    Удалить пользователя по его идентификатору.
    """
    return users.delete_user(db, user_id=user_id)

from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session

from app.crud.users_crud import update_user_current_question
# from app import schemas
from app.database import get_db
from app.crud import users_crud
from app.schemas.user_schema import User, UserCreate, UserUpdateCurrentQuestion

router = APIRouter(tags=["Users"])


"""GET"""


@router.get("/users/", response_model=list[User])
def read_users(db: Session = Depends(get_db)):
    """
    Получить список всех пользователей.
    """
    all_users = users_crud.get_users(db)
    return all_users


@router.get("/user/{user_id}", response_model=User)
def read_user(user_id: int, db: Session = Depends(get_db)):
    """
    Получить конкретного пользователя по его идентификатору.
    """
    user = users_crud.get_user(db, user_id=user_id)
    if user is None:
        raise HTTPException(status_code=404, detail="User not found")
    return user


"""POST"""


@router.post("/add_user/", response_model=User)
def create_user(user: UserCreate, db: Session = Depends(get_db)):
    """
    Создать нового пользователя.
    """
    new_user = users_crud.create_user(db, user=user)
    return new_user


"""PUT"""


@router.post("/update_current_question/{user_id}", response_model=User)
def update_current_question(user_id: int, update_data: UserUpdateCurrentQuestion, db: Session = Depends(get_db)):
    """
    Обновить currentgamequestionid для пользователя.
    """
    user = update_user_current_question(db, user_id, update_data.currentgamequestionid)
    return user


"""DELETE"""


@router.delete("/users/{user_id}", response_model=User)
def delete_user(user_id: int, db: Session = Depends(get_db)):
    """
    Удалить пользователя по его идентификатору.
    """
    return users_crud.delete_user(db, user_id=user_id)

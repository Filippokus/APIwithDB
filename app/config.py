from pydantic_settings import BaseSettings
from pathlib import Path

class Settings(BaseSettings):
    POSTGRES_DB: str
    POSTGRES_USER: str
    POSTGRES_PASSWORD: str
    POSTGRES_HOST: str
    DB_HOST_PORT: str
    # DB_CONTAINER_PORT: str
    API_HOST_PORT: str
    # API_CONTAINER_PORT: str
    DEBUG: bool = True
    POSTGRES_DEBUG: bool = True

    class Config:
        env_file = Path(__file__).resolve().parent.parent.parent / ".env"
        print(f"Loading .env from {env_file}")  # Добавьте эту строку для отладки


settings = Settings()

import os
from dotenv import load_dotenv

# Загрузить переменные окружения из файла .env
load_dotenv()


class Settings:
    SECRET_KEY: str = os.getenv("SECRET_KEY")
    DATABASE_URL: str = os.getenv("DATABASE_URL")
    DEBUG: bool = os.getenv("DEBUG", "False").lower() in ("true", "1", "t")


settings = Settings()

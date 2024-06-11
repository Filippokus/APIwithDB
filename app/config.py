from pydantic_settings import BaseSettings


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
        env_file = ".env"


settings = Settings()

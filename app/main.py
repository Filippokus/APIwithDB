from fastapi import FastAPI
from app.routers import game_questions, game_answers, users
from app.config import settings

app = FastAPI()

app.include_router(game_questions.router, prefix="/api")
app.include_router(game_answers.router, prefix="/api")
app.include_router(users.router, prefix="/api")

@app.get("/", tags=["Root"])
def read_root():
    return {
        "message": "Welcome to the API",
        # "database_url": settings.DATABASE_URL,
        # "secret_key": settings.SECRET_KEY,
        # "debug": settings.DEBUG,
    }


if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000, reload=settings.DEBUG)
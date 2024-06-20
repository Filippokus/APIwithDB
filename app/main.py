from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from app.routers import game_questions_router, game_answers_router, users_router, user_answers_router, psychological_router
from app.config import settings

app = FastAPI()

origins = [
    "http://localhost.tiangolo.com",
    "https://localhost.tiangolo.com",
    "http://localhost:5173",
    "http://localhost:3000",
    "https://localhost:3000",
    "http://localhost",
    "http://localhost:8080"
]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["GET", "POST", "OPTIONS", "DELETE", "PATCH", "PUT"],
    allow_headers=["Content-Type", "Set-Cookie", "Access-Control-Allow-Headers", "Access-Control-Allow-Origin",
                   "Authorization"],
)

app.include_router(game_questions_router.router, prefix="/api")
app.include_router(game_answers_router.router, prefix="/api")
app.include_router(users_router.router, prefix="/api")
app.include_router(user_answers_router.router, prefix="/api")
app.include_router(psychological_router.router, prefix="/api")

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
    
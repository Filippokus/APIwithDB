@echo off
SETLOCAL

:: Установить виртуальное окружение, если еще не установлено
if not exist "venv\Scripts\activate" (
    python -m venv venv
)

:: Активировать виртуальное окружение
call venv\Scripts\activate

:: Установить зависимости
call pip install -r requirements.txt

:: Установить переменные среды для подключения к PostgreSQL
set POSTGRES_USER=postgres
set POSTGRES_PASSWORD=ваш_пароль
set POSTGRES_DB=petsitters
set POSTGRES_HOST=localhost
set POSTGRES_PORT=5432

:: Проверить, существует ли база данных и создать ее, если нет
psql -U %POSTGRES_USER% -h %POSTGRES_HOST% -c "SELECT 1 FROM pg_database WHERE datname = '%POSTGRES_DB%';" | findstr /C:"1 row" >nul
if errorlevel 1 (
    echo Создание базы данных %POSTGRES_DB%
    psql -U %POSTGRES_USER% -h %POSTGRES_HOST% -c "CREATE DATABASE %POSTGRES_DB%;"
)

:: Восстановить базу данных из дампа
echo Восстановление базы данных из дампа
psql -U %POSTGRES_USER% -h %POSTGRES_HOST% -d %POSTGRES_DB% -f "database_dump.sql"

:: Запустить сервер
call uvicorn app.main:app --host 0.0.0.0 --port 8000 --reload

:: Оставить консоль открытой
pause
ENDLOCAL


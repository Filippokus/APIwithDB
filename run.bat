@echo off
SETLOCAL ENABLEDELAYEDEXPANSION

:: Установить кодовую страницу на UTF-8
chcp 65001

:: Check if config.txt exists
if not exist config.txt (
    echo Введите путь к pg_ctl:
    set /p PG_CTL_PATH=
    echo Введите путь к pg_data:
    set /p PG_DATA_PATH=
    echo Введите пользователя PostgreSQL:
    set /p POSTGRES_USER=
    echo Введите имя базы данных PostgreSQL:
    set /p POSTGRES_DB=
    echo Введите пароль пользователя PostgreSQL:
    set /p POSTGRES_PASSWORD=

    :: Save the values to config.txt
    echo PG_CTL_PATH="!PG_CTL_PATH!">config.txt
    echo PG_DATA_PATH="!PG_DATA_PATH!">>config.txt
    echo POSTGRES_USER=!POSTGRES_USER!>>config.txt
    echo POSTGRES_DB=!POSTGRES_DB!>>config.txt
    echo POSTGRES_PASSWORD=!POSTGRES_PASSWORD!>>config.txt
) else (
    :: Load the values from config.txt
    for /f "tokens=1,* delims==" %%i in (config.txt) do (
        set %%i=%%j
    )
)

:: Remove quotes from paths
set PG_CTL_PATH=%PG_CTL_PATH:"=%
set PG_DATA_PATH=%PG_DATA_PATH:"=%

:: Print loaded values for debugging
echo PG_CTL_PATH=!PG_CTL_PATH!
echo PG_DATA_PATH=!PG_DATA_PATH!
echo POSTGRES_USER=!POSTGRES_USER!
echo POSTGRES_DB=!POSTGRES_DB!
echo POSTGRES_PASSWORD=!POSTGRES_PASSWORD!

:: Установить переменную среды PGPASSWORD
set PGPASSWORD=%POSTGRES_PASSWORD%

:: Создать файл .env с переменными среды, если он не существует
if not exist .env (
    echo Создание файла .env
    (
    echo SECRET_KEY=804876b6a4ef870e7bfda138fc037dc4b746cb3aea222ad6a14913f6597ccfc9
    echo DATABASE_URL=postgresql://%POSTGRES_USER%:%POSTGRES_PASSWORD%@localhost:5432/%POSTGRES_DB%
    echo DEBUG=True
    ) > .env
)

:: Установить виртуальное окружение, если еще не установлено
if not exist "venv\Scripts\activate" (
    if not exist ".venv\Scripts\activate" (
        python -m venv venv
    ) else (
        set VENV_PATH=.venv
    )
) else (
    set VENV_PATH=venv
)

if "%VENV_PATH%"=="" set VENV_PATH=venv

:: Активировать виртуальное окружение
call %VENV_PATH%\Scripts\activate

:: Проверить наличие зависимостей и установить их при необходимости
pip show psycopg2 >nul 2>&1
if errorlevel 1 (
    echo Установка psycopg2
    call pip install psycopg2
)

pip show uvicorn >nul 2>&1
if errorlevel 1 (
    echo Установка зависимостей
    call pip install -r requirements.txt
) else (
    echo Зависимости уже установлены
)

:: Установить переменные среды для подключения к PostgreSQL
set PG_CTL="%PG_CTL_PATH%"
set PG_DATA="%PG_DATA_PATH%"
set POSTGRES_USER=%POSTGRES_USER%
set POSTGRES_DB=%POSTGRES_DB%
set POSTGRES_PASSWORD=%POSTGRES_PASSWORD%
set DATABASE_URL=postgresql://%POSTGRES_USER%:%POSTGRES_PASSWORD%@localhost:5432/%POSTGRES_DB%

:: Проверить состояние сервера базы данных и остановить, если он запущен
%PG_CTL% -D %PG_DATA% status >nul 2>&1
if %errorlevel% == 0 (
    echo Сервер базы данных запущен, останавливаем его.
    %PG_CTL% -D %PG_DATA% stop
)

:: Запустить сервер базы данных
%PG_CTL% -D %PG_DATA% start

:: Проверить, существует ли база данных и создать ее, если нет
psql -U %POSTGRES_USER% -h localhost -tc "SELECT 1 FROM pg_database WHERE datname = '%POSTGRES_DB%'" | findstr /C:"1" >nul
if errorlevel 1 (
    echo Создание базы данных %POSTGRES_DB%
    createdb -U %POSTGRES_USER% -h localhost %POSTGRES_DB%
)

:: Проверить, существуют ли таблицы и восстановить базу данных из дампа, если таблицы отсутствуют
psql -U %POSTGRES_USER% -h localhost -d %POSTGRES_DB% -c "SELECT to_regclass('petsitters.gamequestion')" | findstr /C:"petsitters.gamequestion" >nul
if errorlevel 1 (
    echo Восстановление базы данных из дампа
    pg_restore -U %POSTGRES_USER% -h localhost -d %POSTGRES_DB% "database_dump.sql"
)

:: Инициализация colorama
call python -c "import colorama; colorama.init()"

:: Запустить сервер FastAPI
call %VENV_PATH%\Scripts\uvicorn app.main:app --host 0.0.0.0 --port 8000 --reload

:: Оставить консоль открытой
pause

:: Остановить сервер базы данных при завершении
%PG_CTL% -D %PG_DATA% stop
ENDLOCAL

# APIwithDB  
  
## Описание  
  
Этот проект представляет собой API на основе FastAPI с использованием базы данных PostgreSQL, развернутых в Docker.
  
## Требования  
  
- Docker
- Docker Compose
- DBeaver (опционально, для того что бы посмотреть БД)
  
## Установка  
  
### 1. Клонируйте репозиторий:  
```sh
cd <ваша директория>
git clone https://github.com/Filippokus/APIwithDB
```
### 2. Создайте файл `.env` в корне проекта и укажите следующие переменные:
В `DATABASE_URL` оставьте порт `5432`.
```makefile
DATABASE_URL=postgresql://postgres:postgrespass@db:5432/petsitters
POSTGRES_USER=postgres (по умолчанию)
POSTGRES_PASSWORD=postgrespass (ваш пароль)
POSTGRES_DB=petsitters (название базы данных)
```
## Запуск

1. Остановите и удалите все существующие контейнеры, если они есть:

`docker-compose down -v`

2. Запустите контейнеры:

`docker-compose up --build`

Это создаст и запустит два контейнера:

- `petsitters_db`: контейнер с PostgreSQL и базой данных, инициализированный из `backup.sql`.
- `petsitters_api`: контейнер с FastAPI приложением.

API будет доступен по адресу: `http://localhost:8000`, что бы посмотреть и воспользоваться запросами: http://127.0.0.1:8000/docs


## Подключение к базе данных

Вы можете подключиться к базе данных с помощью DBeaver или другого клиента, используя следующие настройки:

- Хост: `localhost`
- Порт: `5433`
- Пользователь: `postgres`
- Пароль: `postgrespass`
- База данных: `petsitters`
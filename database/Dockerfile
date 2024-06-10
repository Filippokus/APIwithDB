# Используем официальный образ PostgreSQL
FROM postgres:16.3

# Устанавливаем аргументы для переменных окружения
ARG POSTGRES_DB
ARG POSTGRES_USER
ARG POSTGRES_PASSWORD

# Присваиваем значения переменным окружения
ENV POSTGRES_DB=${POSTGRES_DB}
ENV POSTGRES_USER=${POSTGRES_USER}
ENV POSTGRES_PASSWORD=${POSTGRES_PASSWORD}

# Копируем дамп базы данных в контейнер
COPY database/backup.sql /docker-entrypoint-initdb.d/

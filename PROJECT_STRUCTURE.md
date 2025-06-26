# Структура проекта Telegram Bot MVP

## Файлы проекта

```
telegram-bot-mvp/
├── 📄 main.py                 # Основной код бота
├── 📄 requirements.txt        # Python зависимости
├── 📄 Procfile               # Команда запуска для Railway
├── 📄 runtime.txt            # Версия Python для Railway
├── 📄 railway.json           # Конфигурация Railway
├── 📄 create_tables.sql      # SQL скрипт создания таблиц
├── 📄 .env.example           # Пример переменных окружения (локально)
├── 📄 .env.railway           # Пример переменных для Railway
├── 📄 .gitignore             # Исключения для Git
├── 📄 README.md              # Основная документация
├── 📄 RAILWAY_DEPLOY.md      # Руководство по деплою на Railway
├── 📄 test_health.py         # Скрипт тестирования health check
└── 📄 PROJECT_STRUCTURE.md   # Этот файл
```

## Описание файлов

### Основные файлы

- **`main.py`** - Основной код Telegram бота с полной функциональностью
- **`requirements.txt`** - Список Python зависимостей
- **`README.md`** - Подробная документация по установке и использованию

### Файлы для Railway

- **`Procfile`** - Указывает команду запуска для Railway
- **`runtime.txt`** - Указывает версию Python (3.12.0)
- **`railway.json`** - Конфигурация Railway с настройками деплоя

### База данных

- **`create_tables.sql`** - SQL скрипт для ручного создания таблиц (опционально)

### Конфигурация

- **`.env.example`** - Пример файла с переменными окружения для локальной разработки
- **`.env.railway`** - Пример переменных для Railway (только для справки)
- **`.gitignore`** - Исключает чувствительные файлы из Git

### Документация

- **`RAILWAY_DEPLOY.md`** - Подробное руководство по деплою на Railway
- **`PROJECT_STRUCTURE.md`** - Описание структуры проекта

### Утилиты

- **`test_health.py`** - Скрипт для тестирования health check endpoint

## Ключевые особенности

### 🚀 Railway Ready
- Автоматическое определение типа приложения
- Встроенный health check сервер
- Автоматические перезапуски при ошибках
- Поддержка PostgreSQL из коробки

### 🔒 Безопасность
- Все секреты в переменных окружения
- .gitignore исключает чувствительные данные
- Никаких хардкодных токенов

### 📊 Мониторинг
- HTTP health check endpoints
- Подробное логирование
- Статус подключения к базе данных

### 🛠 Разработка
- Поддержка локальной разработки
- Автоматическое создание таблиц
- Тестовые утилиты

## Быстрый старт

### Локально
```bash
pip install -r requirements.txt
export TELEGRAM_TOKEN="your_token"
export DATABASE_URL="postgresql://..."
python main.py
```

### Railway
1. Форк репозитория
2. Создать проект на Railway
3. Подключить GitHub
4. Добавить PostgreSQL
5. Установить TELEGRAM_TOKEN
6. Деплой готов! 🎉

## Переменные окружения

### Обязательные
- `TELEGRAM_TOKEN` - токен Telegram бота

### Автоматические (Railway)
- `DATABASE_URL` - строка подключения к PostgreSQL
- `PORT` - порт для HTTP сервера

## Зависимости

- `python-telegram-bot[job-queue]==21.0.1` - Telegram Bot API
- `psycopg[binary]==3.1.18` - PostgreSQL драйвер
- `aiohttp==3.9.1` - HTTP сервер для health check
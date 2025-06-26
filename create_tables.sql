-- SQL скрипт для создания таблиц Telegram Bot MVP
-- Выполните этот скрипт в вашей базе данных PostgreSQL

-- Таблица чатов
CREATE TABLE IF NOT EXISTS chats (
    id BIGINT PRIMARY KEY,
    type VARCHAR(255) NOT NULL,
    title TEXT,
    username VARCHAR(255) UNIQUE,
    first_seen_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    last_updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Таблица пользователей
CREATE TABLE IF NOT EXISTS users (
    id BIGINT PRIMARY KEY,
    is_bot BOOLEAN NOT NULL,
    first_name TEXT,
    last_name TEXT,
    username VARCHAR(255) UNIQUE,
    language_code VARCHAR(10),
    first_seen_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Таблица сообщений
CREATE TABLE IF NOT EXISTS messages (
    message_id BIGINT NOT NULL,
    chat_id BIGINT NOT NULL,
    user_id BIGINT NOT NULL,
    text TEXT,
    sent_at TIMESTAMPTZ NOT NULL,
    raw_message JSONB,

    PRIMARY KEY (chat_id, message_id),
    FOREIGN KEY (chat_id) REFERENCES chats(id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE SET NULL
);

-- Индексы для оптимизации запросов
CREATE INDEX IF NOT EXISTS idx_messages_chat_id ON messages(chat_id);
CREATE INDEX IF NOT EXISTS idx_messages_user_id ON messages(user_id);
CREATE INDEX IF NOT EXISTS idx_messages_sent_at ON messages(sent_at);
CREATE INDEX IF NOT EXISTS idx_chats_username ON chats(username) WHERE username IS NOT NULL;
CREATE INDEX IF NOT EXISTS idx_users_username ON users(username) WHERE username IS NOT NULL;

-- Комментарии к таблицам для документации
COMMENT ON TABLE chats IS 'Информация о чатах Telegram';
COMMENT ON TABLE users IS 'Информация о пользователях Telegram';
COMMENT ON TABLE messages IS 'Сообщения из чатов Telegram';

COMMENT ON COLUMN chats.id IS 'Уникальный ID чата в Telegram';
COMMENT ON COLUMN chats.type IS 'Тип чата (group, supergroup, private, channel)';
COMMENT ON COLUMN chats.title IS 'Название чата';
COMMENT ON COLUMN chats.username IS 'Username чата (если есть)';

COMMENT ON COLUMN users.id IS 'Уникальный ID пользователя в Telegram';
COMMENT ON COLUMN users.is_bot IS 'Является ли пользователь ботом';
COMMENT ON COLUMN users.first_name IS 'Имя пользователя';
COMMENT ON COLUMN users.last_name IS 'Фамилия пользователя';
COMMENT ON COLUMN users.username IS 'Username пользователя';
COMMENT ON COLUMN users.language_code IS 'Код языка пользователя';

COMMENT ON COLUMN messages.message_id IS 'ID сообщения в рамках чата';
COMMENT ON COLUMN messages.chat_id IS 'ID чата, в котором отправлено сообщение';
COMMENT ON COLUMN messages.user_id IS 'ID пользователя, отправившего сообщение';
COMMENT ON COLUMN messages.text IS 'Текст сообщения';
COMMENT ON COLUMN messages.sent_at IS 'Время отправки сообщения';
COMMENT ON COLUMN messages.raw_message IS 'Полные данные сообщения в формате JSON';
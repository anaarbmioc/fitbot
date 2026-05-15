CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  telegram_id BIGINT UNIQUE,
  name TEXT,
  google_token TEXT,
  google_refresh TEXT,
  accepted_terms_at TIMESTAMP
);

CREATE TABLE groups (
  id SERIAL PRIMARY KEY,
  telegram_group_id BIGINT UNIQUE,
  challenge_start DATE,
  challenge_days INT CHECK (challenge_days BETWEEN 2 AND 365),
  status TEXT DEFAULT 'waiting'
);

CREATE TABLE group_members (
  group_id INT REFERENCES groups(id),
  user_id INT REFERENCES users(id),
  status TEXT DEFAULT 'pending',
  joined_at TIMESTAMP,
  PRIMARY KEY (group_id, user_id)
);

CREATE TABLE daily_activity (
  id SERIAL PRIMARY KEY,
  user_id INT REFERENCES users(id),
  group_id INT REFERENCES groups(id),
  date DATE,
  steps INT,
  calories FLOAT,
  exercise_minutes INT,
  UNIQUE (user_id, group_id, date)
);
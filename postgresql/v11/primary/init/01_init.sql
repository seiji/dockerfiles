CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(50) NOT NULL
);

INSERT INTO users (name) VALUES ('foo'), ('bar');

CREATE TABLESPACE space1 LOCATION '/var/lib/postgresql/app';

CREATE TABLE posts (
  id SERIAL PRIMARY KEY,
  uid INTEGER REFERENCES users(id),
  title VARCHAR(50) NOT NULL
) TABLESPACE space1;

INSERT INTO posts (uid, title) VALUES (1, 'title_foo'), (2, 'title_bar');

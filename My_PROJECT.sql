DROP DATABASE IF EXISTS project;
CREATE DATABASE project;
USE project;

DROP TABLE IF EXISTS users;
CREATE TABLE users (
	id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	firstname VARCHAR(50) COMMENT 'Имя',
	lastname VARCHAR(50) COMMENT 'Фамилия',
    email VARCHAR(120) UNIQUE COMMENT 'Электронная почта',
    nickname VARCHAR(120) UNIQUE COMMENT 'Никнейм на сайте')
    COMMENT 'Пользователи';
 
INSERT INTO users VALUE (1, 'Иван', 'Иванов', 'ivn@mail.ru', 'Ivan');
INSERT INTO users VALUE (2, 'Петр', 'Петров', 'ptr@mail.ru', 'Petr');
INSERT INTO users VALUE (3, 'Алексей', 'Козлов', 'alx@mail.ru', 'Alex');
INSERT INTO users VALUE (4, 'Евгений', 'Шамаев', 'evg@mail.ru', 'John');
INSERT INTO users VALUE (5, 'Сергей', 'Смирнов', 'srg@mail.ru', 'Serg');
 
DROP TABLE IF EXISTS films;
CREATE TABLE films (
	id SERIAL,
    name_film VARCHAR(50) COMMENT 'Имя фильма',
    films_of_site BIGINT NOT NULL DEFAULT 5
    );
 
INSERT INTO films VALUE (1, 'Матрица', films_of_site);
INSERT INTO films VALUE (2, 'Властелин колец', films_of_site);
INSERT INTO films VALUE (3, 'Форсаж', films_of_site);
INSERT INTO films VALUE (4, 'Аватар', films_of_site);
INSERT INTO films VALUE (5, 'Титаник', films_of_site);
 
DROP TABLE IF EXISTS films_of_profile;
CREATE TABLE films_of_profile (
	id SERIAL,
    users_id BIGINT UNSIGNED NOT NULL,
    films_of_profile BIGINT NOT NULL DEFAULT 5,
    
    FOREIGN KEY (users_id) REFERENCES users(id),
    FOREIGN KEY (id) REFERENCES films(id)
    );

INSERT INTO films_of_profile VALUE (3, 1, 2);
INSERT INTO films_of_profile VALUE (4, 2, 3);
INSERT INTO films_of_profile VALUE (5, 3, 4);

DROP TABLE IF EXISTS favorite_films;
CREATE TABLE favorite_films (
	users_id BIGINT UNSIGNED NOT NULL,
	id_film BIGINT UNSIGNED NOT NULL,
    
    FOREIGN KEY (users_id) REFERENCES users(id),
	FOREIGN KEY (id_film) REFERENCES films(id));

INSERT INTO favorite_films VALUE (1, 4);
INSERT INTO favorite_films VALUE (2, 3);
INSERT INTO favorite_films VALUE (3, 3);
INSERT INTO favorite_films VALUE (4, 5);
INSERT INTO favorite_films VALUE (5, 1);

DROP TABLE IF EXISTS last_video;
CREATE TABLE last_video (
	id SERIAL,
	users_id BIGINT UNSIGNED NOT NULL,
    number_films BIGINT UNSIGNED NOT NULL,
    created_at DATETIME DEFAULT NOW(),

	FOREIGN KEY (number_films) REFERENCES films(id),
    FOREIGN KEY (users_id) REFERENCES users(id)
    );

INSERT INTO last_video VALUE (1, 4, 3, created_at);

DROP TABLE IF EXISTS type_of_films;
CREATE TABLE type_of_films (
	id SERIAL,
    `type` VARCHAR(50) COMMENT 'Жанр'
    );
	
INSERT INTO type_of_films VALUES (1, 'Ужасы');
INSERT INTO type_of_films VALUES (2, 'Триллер');
INSERT INTO type_of_films VALUES (3, 'Мальт');
INSERT INTO type_of_films VALUES (4, 'Экшн');

DROP TABLE IF EXISTS duration_of_subscription;
CREATE TABLE duration_of_subscription (
	id SERIAL,
    users_id BIGINT UNSIGNED NOT NULL,
    duration_day BIGINT UNSIGNED NOT NULL,
    
    FOREIGN KEY (users_id) REFERENCES users(id)
    );
  
INSERT INTO duration_of_subscription VALUES (1, 2, 27);
INSERT INTO duration_of_subscription VALUES (2, 4, 7);
INSERT INTO duration_of_subscription VALUES (3, 1, 19);
    
DROP TABLE IF EXISTS comments;
CREATE TABLE comments (
	id SERIAL,
	from_user_id BIGINT UNSIGNED NOT NULL,
    body TEXT,
    created_at DATETIME DEFAULT NOW(),

    FOREIGN KEY (from_user_id) REFERENCES users(id)
);

INSERT INTO comments VALUES (1, 4, 'Отличный фильм', created_at);
INSERT INTO comments VALUES (2, 1, 'Очень понравилось', created_at);
INSERT INTO comments VALUES (3, 2, 'Слишком затянутый', created_at);



DROP TABLE IF EXISTS likes;
CREATE TABLE likes (
	id SERIAL,
    user_id BIGINT UNSIGNED NOT NULL,
    films_id BIGINT UNSIGNED NOT NULL,
    
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (films_id) REFERENCES films(id)
);

INSERT INTO likes VALUES (1, 4, 1);
INSERT INTO likes VALUES (2, 1, 2);
INSERT INTO likes VALUES (3, 2, 5);

DROP TABLE IF EXISTS `change`;
CREATE TABLE `change` (
	id SERIAL,
    `text` TEXT);


ALTER TABLE type_of_films MODIFY  `type` VARCHAR(30);
ALTER TABLE type_of_films RENAME TO genre;


-- SELECT * FROM users ORDER BY firstname DESC;



-- SELECT u.firstname 'Имя', pf.users_id 'Номер фильма'
-- FROM users u
-- RIGHT OUTER JOIN  films_of_profile pf ON pf.id = u.id



-- SELECT * FROM duration_of_subscription WHERE duration_day > 10;



-- CREATE VIEW TEST AS
-- SELECT firstname, email
-- FROM users
-- WHERE users.id = 4;
-- SELECT * FROM TEST;



-- CREATE VIEW TEST1 AS
-- SELECT id, body
-- FROM comments
-- WHERE id = 2;
-- SELECT * FROM TEST1;  



-- CREATE PROCEDURE script()
-- SELECT * FROM users ORDER BY nickname DESC;
-- CALL script;



-- CREATE TRIGGER `after_insert`
-- AFTER INSERT ON likes FOR EACH ROW
-- INSERT INTO `change` (id, `text`)
-- VALUES (NEW.id, 'Добавление');
-- INSERT INTO likes VALUES (10, 5, 3);
-- SELECT * FROM `change`;





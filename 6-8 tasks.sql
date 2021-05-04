-- скрипты характерных выборок (включающие группировки, JOIN'ы, вложенные таблицы)

-- средний возраст пользователей сервиса
SELECT
  AVG(TIMESTAMPDIFF(YEAR, birthday, NOW())) AS age
FROM
  users;

-- Вывод таблицы книг с их авторами

SELECT
  b.id,
  b.name AS book,
  b.price,
  CONCAT(a.first_name, " ", a.last_name) AS author
  FROM books AS b
    LEFT JOIN authors AS a
      ON b.author_id = a.id;
      
-- Выборка книг пользователя

SELECT CONCAT(users.first_name, " ", users.last_name) AS user, books.name AS book
  FROM books_users
    JOIN users
      ON books_users.user_id = users.id
		JOIN books
			ON books.id = books_users.book_id
  WHERE books_users.user_id = 21;
  
-- книги, которые понравились пользователям

SELECT * FROM books WHERE rating_LitRes > 4.5 order by rating_LitRes DESC;
  
-- представления (минимум 2)
-- таблица названий книг и их авторов
CREATE OR REPLACE VIEW authors_books AS
SELECT
  CONCAT(a.first_name, " ", a.last_name) AS author,
  b.name AS book
FROM
  authors AS a
JOIN
  books AS b
ON
  b.author_id = a.id;
  
-- таблица библиотек и пользователей
CREATE OR REPLACE VIEW users_libraries AS
SELECT
  CONCAT(u.first_name, " ", u.last_name) AS user,
  l.name AS library
FROM libraries_users
    JOIN users AS u
      ON libraries_users.user_id = u.id
		JOIN libraries as l
			ON l.id = libraries_users.library_id;
            
-- таблица пользователей и их бонусных карт
CREATE OR REPLACE VIEW users_bonus_cards AS
SELECT
  CONCAT(u.first_name, " ", u.last_name) AS user,
  bc.name AS bonus_card
FROM
  bonus_cards AS bc
JOIN
  users AS u
ON
  u.bonus_card_id = bc.id;
  
-- хранимые процедуры / триггеры;
-- Создание триггера для обработки target_id
 
DROP FUNCTION IF EXISTS is_row_exists;
DELIMITER //

CREATE FUNCTION is_row_exists (target_id INT, review_type_id INT)
RETURNS BOOLEAN READS SQL DATA

BEGIN
  DECLARE table_name VARCHAR(50);
  SELECT name FROM review_types WHERE id = review_type_id INTO table_name;
  
  CASE table_name
    WHEN 'Автор' THEN
      RETURN EXISTS(SELECT 1 FROM authors WHERE id = target_id);
    WHEN 'Книга' THEN 
      RETURN EXISTS(SELECT 1 FROM books WHERE id = target_id);
    ELSE 
      RETURN FALSE;
  END CASE;
  
END//

DELIMITER ;

SELECT is_row_exists(1, 1);
 
DROP TRIGGER IF EXISTS reviews_validation;
DELIMITER //

CREATE TRIGGER reviews_validation BEFORE INSERT ON reviews

FOR EACH ROW BEGIN
  IF !is_row_exists(NEW.target_id, NEW.review_type_id) THEN
    SIGNAL SQLSTATE "45000"
    SET MESSAGE_TEXT = "Error adding review! Target table doesn't contain row id provided!";
  END IF;
END//

DELIMITER ;

-- 

CREATE TABLE Logs (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    created_at datetime DEFAULT CURRENT_TIMESTAMP,
    table_name varchar(50) NOT NULL,
    row_id INT UNSIGNED NOT NULL,
    row_name varchar(255)
) ENGINE = Archive;

CREATE TRIGGER users_insert AFTER INSERT ON users
FOR EACH ROW
BEGIN
    INSERT INTO Logs VALUES (NULL, DEFAULT, "users", NEW.id, NEW.first_name, NEW.last_name);
END;

CREATE TRIGGER authors_insert AFTER INSERT ON authors
FOR EACH ROW
BEGIN
    INSERT INTO Logs VALUES (NULL, DEFAULT, "authors", NEW.id, NEW.firs_name, NEW.last_name);
END;

CREATE TRIGGER books_insert AFTER INSERT ON books
FOR EACH ROW
BEGIN
    INSERT INTO Logs VALUES (NULL, DEFAULT, "books", NEW.id, NEW.name);
END;
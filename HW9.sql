/* 1.В базе данных shop и sample присутствуют одни и те же таблицы, учебной базы данных.
Переместите запись id = 1 из таблицы shop.users в таблицу sample.users.
Используйте транзакции.*/

START TRANSACTION;
  INSERT INTO sample.users SELECT * FROM shop.users WHERE id = 1;
  DELETE FROM shop.users WHERE id = 1;
COMMIT;

/*2.Создайте представление, которое выводит название name товарной 
позиции из таблицы products и соответствующее название 
каталога name из таблицы catalogs.*/

CREATE OR REPLACE VIEW names_from_products_catalogs AS
SELECT
  products.name AS product,
  catalogs.name AS catalog
FROM
  products
JOIN
  catalogs
ON
  products.catalog_id = catalogs.id;
  
  SELECT * FROM names_from_products_catalogs;

/*3.Пусть имеется таблица с календарным полем created_at.
В ней размещены разреженые календарные записи за август 2018 года '2018-08-01', '2018-08-04', '2018-08-16' и 2018-08-17. 
Составьте запрос, который выводит полный список дат за август, выставляя в соседнем поле значение 1, 
если дата присутствует в исходном таблице и 0, если она отсутствует.*/

CREATE TABLE IF NOT EXISTS test_table (
  id INT UNSIGNED NOT NULL PRIMARY KEY,
  name VARCHAR(255),
  created_at DATE NOT NULL
);

INSERT INTO test_table VALUES
(1, "первое августа", "2018-08-01"),
(2, "четвертое августа", "2018-08-04"),
(3, "шестнадцатое августа", "2018-08-16"),
(4, "семнадцатое августа", "2018-08-17");

CREATE TABLE august (
  day INT
);

INSERT INTO august VALUES
(1), (2), (3), (4), (5), (6), (7), (8), (9), (10), (11), 
(12), (13), (14), (15), (16), (17), (18), (19), (20), (21),
(22), (23), (24), (25), (26), (27), (28), (29), (30), (31);

SELECT DATE("2018-08-31") - INTERVAL l.day DAY AS day, NOT ISNULL(test_table.name) AS order_exist
FROM august AS l
LEFT JOIN test_table ON DATE(DATE("2018-08-31") - INTERVAL l.day DAY) = test_table.created_at
ORDER BY day;

/* 4.Пусть имеется любая таблица с календарным полем created_at. 
Создайте запрос, который удаляет устаревшие записи из таблицы, оставляя только 5 самых свежих записей.*/

CREATE TABLE IF NOT EXISTS test_table_2 (
  id INT UNSIGNED NOT NULL PRIMARY KEY,
  name VARCHAR(255),
  created_at DATE NOT NULL
);

INSERT INTO test_table_2 VALUES
(1, "30 марта", "2018-03-30"),
(2, "1 сентября", "2018-09-01"),
(3, "31 декабря", "2018-12-31"),
(4, "28 апреля", "2018-04-28"),
(5, "8 марта", "2018-03-08"),
(6, "4 ноября", "2018-11-04");


DELETE test_table_2 FROM test_table_2
JOIN (SELECT created_at FROM test_table_2 ORDER BY created_at DESC LIMIT 5, 1) AS newest
ON test_table_2.created_at <= newest.created_at;
SELECT * FROM test_table_2;


/* 1.Создайте хранимую функцию hello(), которая будет возвращать приветствие, в зависимости от текущего времени суток. 
С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро", 
с 12:00 до 18:00 функция должна возвращать фразу "Добрый день", 
с 18:00 до 00:00 — "Добрый вечер", 
с 00:00 до 6:00 — "Доброй ночи".*/

DELIMITER //

CREATE FUNCTION hello ()
RETURNS TINYTEXT NO SQL
BEGIN
  DECLARE hour INT;
  SET hour = HOUR(NOW());
  CASE
    WHEN hour BETWEEN 0 AND 5 THEN
      RETURN "Доброй ночи";
    WHEN hour BETWEEN 6 AND 11 THEN
      RETURN "Доброе утро";
    WHEN hour BETWEEN 12 AND 17 THEN
      RETURN "Добрый день";
    WHEN hour BETWEEN 18 AND 23 THEN
      RETURN "Добрый вечер";
  END CASE;
END//

DELIMITER ;
SELECT NOW(), hello ();

/*2.В таблице products есть два текстовых поля: name с названием товара и description с его описанием. 
Допустимо присутствие обоих полей или одного из них.
Ситуация, когда оба поля принимают неопределенное значение NULL неприемлема. 
Используя триггеры, добейтесь того, чтобы одно из этих полей или оба поля были заполнены.
При попытке присвоить полям NULL-значение необходимо отменить операцию.*/

DELIMITER //

CREATE TRIGGER if_name_and_description_is_null BEFORE INSERT ON products
FOR EACH ROW BEGIN
  IF NEW.name IS NULL AND NEW.description IS NULL THEN
    SIGNAL SQLSTATE "45000"
    SET MESSAGE_TEXT = "Both product name and product description are NULL";
  END IF;
END//

DELIMITER ;

INSERT INTO products (name, description) VALUES (NULL, NULL, 9360.00, 2);

INSERT INTO products (name, description) VALUES ("any name", "description");

INSERT INTO products (name, description) VALUES ("any name", NULL);

DELIMITER //

CREATE TRIGGER validate_name_description_update BEFORE UPDATE ON products
FOR EACH ROW BEGIN
  IF NEW.name IS NULL AND NEW.description IS NULL THEN
    SIGNAL SQLSTATE "45000"
    SET MESSAGE_TEXT = "Both product name and product description are NULL";
  END IF;
END//

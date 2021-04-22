/*1. Составьте список пользователей users, которые осуществили хотя бы один заказ orders в интернет магазине.*/

SELECT users.id, users.name FROM users JOIN orders ON users.id = orders.user_id;

/* 2. Выведите список товаров products и разделов catalogs, который соответствует товару. (name, ctalog id)*/

SELECT products.name AS product_name, catalogs.name AS catalog_name FROM products JOIN catalogs ON products.catalog_id = catalogs.id;

/* 3. (по желанию) Пусть имеется таблица рейсов flights (id, from, to) и таблица городов cities (label, name). 
Поля from, to и label содержат английские названия городов, поле name — русское. Выведите список рейсов flights с русскими названиями городов.*/

CREATE TABLE flights(
id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки",
`from` VARCHAR(100) NOT NULL COMMENT "Откуда вылет",
`to` VARCHAR(100) NOT NULL COMMENT "Город приземления");

INSERT INTO flights (`from`, `to`) VALUES ("moscow", "omsk"),
	("novgorod", "kazan"), ("irkutsk", "moskow"), 
    ("omsk", "irkutsk"), ("moscow", "kazan");

CREATE TABLE cities(
label VARCHAR(100) NOT NULL COMMENT "Название города на английском",
name VARCHAR(100) NOT NULL COMMENT "Название города по-русски");

INSERT INTO cities VALUES ("moscow", "Москва"),
	("irkutsk", "Иркутск"), ("novgorod", "Новгород"),
    ("kazan", "Казань"), ("omsk", "Омск");
    
SELECT flights.id, cities_from_flight.name AS `from`, cities_to_flight.name AS `to` FROM flights
  JOIN cities AS cities_from_flight ON flights.from = cities_from_flight.label
  JOIN cities AS cities_to_flight ON flights.to = cities_to_flight.label 
  ORDER BY id;
  

SELECT * FROM users LIMIT 10;
UPDATE users SET bonus_card_id = FLOOR(1 + RAND() * 14);
UPDATE users SET updated_at = now() WHERE updated_at < created_at;

SELECT * FROM libraries;
DROP TABLE IF EXISTS libraries;
CREATE TABLE libraries (
id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки", 
name VARCHAR(255) NOT NULL UNIQUE COMMENT "Название библиотеки",
created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Библиотеки";

INSERT INTO libraries (name) VALUES ("Библиотека № 2 им. А.М. Горького"), ("Детская библиотека №1"), ("Центральная детская библиотека"),
("Библиотека «Охтинская»"), ("Библиотека № 5"), ("Детская библиотека № 6"), ("Дальневосточная государственная научная библиотека г. Хабаровск"),
("Иркутская областная государственная универсальная научная библиотека"), ("Красноярская краевая молодежная библиотека"), ("Липецкая областная юношеская библиотека"),
("МБУ «Централизованная библиотечная система» г. Норильск"), ("Муниципальное казенное учреждение культуры «Охотская районная библиотека»"),
("Национальная библиотека Ямало-Ненецкого Автономного Округа г. Салехард"), ("Российская государственная библиотека для молодежи г.Москва"), 
("Рязанская областная универсальная научная библиотека имени Горького"), ("Самарская областная детская библиотека"), ("Свердловская областная библиотека для детей и юношества"),
("Ставропольская централизованная библиотечная система"), ("Централизованная библиотечная система г. Сургут"), ("Центральная городская детская библиотека имени А.П. Гайдара г.Москва"),
("Центральная городская публичная библиотека имени В.В. Маяковского г. Санкт-Петербург");

SELECT * FROM libraries_users;
UPDATE libraries_users SET library_id = FLOOR(1 + RAND() * 21);

SELECT * FROM operations ORDER BY id;
DROP TABLE IF EXISTS operations;
CREATE TABLE operations (
id INT UNSIGNED NOT NULL PRIMARY KEY COMMENT "Идентификатор строки", 
name VARCHAR(255) NOT NULL UNIQUE COMMENT "Название операции"
) COMMENT "Операции";
INSERT INTO operations (id, name) VALUES (1, "Получена книга по акции"), (2, "Выполнено объединение с пользователем"),
(3, "Покупка книги"), (4, "Начата оплата счета"), (5, "Заказ закрыт"), (6, "Ошибка оплаты"), (7, "Активация купона"),
(8, "Начисление бонуса");

SELECT * FROM operations_users;
UPDATE operations_users SET operation_id = FLOOR(1 + RAND() * 8);

SELECT * FROM payments;
ALTER TABLE payments ADD COLUMN book_id INT AFTER user_id;
UPDATE payments SET book_id = FLOOR(1 + RAND() * 100);
UPDATE payments SET user_id = FLOOR(1 + RAND() * 100);
UPDATE payments SET payment_type_id = FLOOR(1 + RAND() * 3);
UPDATE payments SET amount = FLOOR(49 + RAND() * 5000);

SELECT * FROM payment_types;
DROP TABLE IF EXISTS payment_types;
CREATE TABLE payment_types (
id INT UNSIGNED NOT NULL PRIMARY KEY COMMENT "Идентификатор строки", 
name VARCHAR(255) NOT NULL UNIQUE COMMENT "Название типа платежа"
) COMMENT "Типы платежей";
INSERT INTO payment_types (id, name) VALUES (1, "Оплата бонусами ЛитРес"), (2, "Оплата бонусной картой"), (3, "Оплата банковской картой");

SELECT * FROM bonus_cards ORDER BY id;
DROP TABLE IF EXISTS bonus_cards;
CREATE TABLE bonus_cards (
id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки", 
name VARCHAR(255) NOT NULL UNIQUE COMMENT "Название бонусной карты"
) COMMENT "Бонусные карты";
INSERT INTO bonus_cards (id, name) VALUES (1, "Много.ру"), (2, "Связной Плюс"), (3, "Карта Перекресток"), 
(4, "Семейная команда"), (5, "Карта Билайн"), (6, "BPClub"), (7, "Город (Тройка)"), (8, "Аэрофлот"),
(9, "S7 Priority"), (10, "Карта Ural Airlines"), (11, "Карта Москвича"), (13, "Карта Магнит"), (14, "Не использовать карту");

SELECT * FROM mailing;
DROP TABLE IF EXISTS mailing;
CREATE TABLE mailing (
id INT UNSIGNED NOT NULL PRIMARY KEY COMMENT "Идентификатор строки", 
name VARCHAR(255) NOT NULL UNIQUE COMMENT "Название рассылки"
) COMMENT "Рассылки";
INSERT INTO mailing VALUES (1, "Уведомления об интересных лично вам новинках и акциях на e-mail (~дважды в неделю)"),
(2, "Напоминание о корзине"), (3, "Предложения оставить отзыв и оценить прочитанную книгу (после каждой покупки)"),
(4, "android-push читай (~ежедневно)"), (5, "Уведомления на странице сайта");

SELECT * FROM mailing_users;
UPDATE mailing_users SET mailing_id = FLOOR(1 + RAND() * 5);

SELECT * FROM books;
UPDATE books SET author_id = FLOOR(1 + RAND() * 100);
UPDATE books SET series_id = FLOOR(1 + RAND() * 100);
UPDATE books SET genre_id = FLOOR(1 + RAND() * 141);
UPDATE books SET price = FLOOR(49 + RAND() * 1000);
UPDATE books SET reviews_amount = FLOOR(1 + RAND() * 350);

SELECT * FROM authors;
UPDATE authors SET books_amount = FLOOR(1 + RAND() * 300) WHERE books_amount = 0 OR books_amount > 300;
UPDATE authors SET reviews_amount = FLOOR(1 + RAND() * 250) WHERE reviews_amount > 250;
UPDATE authors SET updated_at = now() WHERE updated_at < created_at;

SELECT * FROM series;

SELECT * FROM genres;

SELECT * FROM genre_groups ORDER BY id;
DROP TABLE IF EXISTS genre_groups;
CREATE TABLE genre_groups (
id INT UNSIGNED NOT NULL PRIMARY KEY COMMENT "Идентификатор строки", 
name VARCHAR(255) NOT NULL UNIQUE COMMENT "Название группы жанров"
) COMMENT "Группы жанров";
INSERT INTO genre_groups VALUES (1, "Легкое чтение"), (2, "Серьезное чтение"), (3, "История"), 
(4, "Бизнес-книги"), (5, "Знания и навыки"), (6, "Психология, мотивация"), (7, "Спорт, здоровье, красота"), (8, "Хобби, досуг"), (9, "Дом, дача"),
(10, "Детские книги"), (11, "Родителям"), (12, "Публицистика и периодические издания"), (13, "Самиздат"), (14, "Черновики");

SELECT * FROM book_types;
DROP TABLE IF EXISTS book_types;
CREATE TABLE book_types (
id INT UNSIGNED NOT NULL PRIMARY KEY COMMENT "Идентификатор строки", 
name VARCHAR(255) NOT NULL UNIQUE COMMENT "Формат книги"
) COMMENT "Типы книг";

INSERT INTO book_types VALUES (1, "FB2"), (2, "EPUB"), (3, "iOS.UPUB"), (4, "TXT"), (5, "RTF"), 
(6, "MOBI"), (7, "FB3"), (8, "PDF"), (9, "MP3"), (10, "M4B"), (11, "ZIP-АРХИВ");

SELECT * FROM litres_ratings;
UPDATE litres_ratings SET book_id = FLOOR(1 + RAND() * 100);
UPDATE litres_ratings SET user_id = FLOOR(1 + RAND() * 100);
UPDATE litres_ratings SET updated_at = now() WHERE updated_at < created_at;

SELECT * FROM tegs;

SELECT * FROM tegs_books;
UPDATE tegs_books SET teg_id = FLOOR(1 + RAND() * 100);
UPDATE tegs_books SET book_id = FLOOR(1 + RAND() * 100);

SELECT * FROM reviews;
UPDATE reviews SET user_id = FLOOR(1 + RAND() * 100);
UPDATE reviews SET likes_amount = FLOOR(1 + RAND() * 500);
UPDATE reviews SET dislikes_amount = FLOOR(1 + RAND() * 250);
UPDATE reviews SET target_type_id = FLOOR(1 + RAND() * 2);
UPDATE reviews SET target_id = FLOOR(1 + RAND() * 100);

SELECT * FROM target_types;
DROP TABLE IF EXISTS target_types;
CREATE TABLE target_types (
  id INT UNSIGNED NOT NULL PRIMARY KEY,
  name VARCHAR(255) NOT NULL UNIQUE,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);
INSERT INTO target_types(id, name) VALUES (1, "Автор"), (2, "Книга");

SELECT * FROM books_users;
UPDATE books_users SET book_id = FLOOR(1 + RAND() * 100);
UPDATE books_users SET user_id = FLOOR(1 + RAND() * 100);
CREATE DATABASE litres;
USE litres;

-- 1. таблица пользователей
DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки", 
  first_name VARCHAR(100) NOT NULL COMMENT "Имя пользователя",
  last_name VARCHAR(100) NOT NULL COMMENT "Фамилия пользователя",
  nickname VARCHAR(100) NOT NULL COMMENT "Псеводним пользователя",
  birthday DATE COMMENT "Дата рождения",
  about TEXT NOT NULL COMMENT "Информация о пользователе",
  email VARCHAR(100) NOT NULL UNIQUE COMMENT "Почта",
  phone VARCHAR(100) NOT NULL UNIQUE COMMENT "Телефон",
  adult_content_restriction BOOLEAN COMMENT "Ограничение на показ взрослого контента",
  bonus_card_id INT UNSIGNED NOT NULL COMMENT "Ссылка на тип бонусной карты",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Пользователи";  

-- 2. таблица  сторонних библиотек
DROP TABLE IF EXISTS libraries;
CREATE TABLE libraries (
id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки", 
name VARCHAR(255) NOT NULL UNIQUE COMMENT "Название библиотеки",
created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Библиотеки";

-- 3. таблица связи библиотек и пользователей
DROP TABLE IF EXISTS libraries_users;
CREATE TABLE libraries_users (
library_id INT UNSIGNED NOT NULL COMMENT "Ссылка на библиотеку",
user_id INT UNSIGNED NOT NULL COMMENT "Ссылка на пользователя",
created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки", 
PRIMARY KEY (library_id, user_id) COMMENT "Составной первичный ключ"
) COMMENT "Пользовтельские библиотеки, связь между пользователями и сторонними библиотеками";

-- 4. таблица операций
DROP TABLE IF EXISTS operations;
CREATE TABLE operations (
id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки", 
name VARCHAR(255) NOT NULL UNIQUE COMMENT "Название операции"
) COMMENT "Операции";

-- 5. таблица связи операций и пользователей
DROP TABLE IF EXISTS operations_users;
CREATE TABLE operations_users (
operation_id INT UNSIGNED NOT NULL COMMENT "Ссылка на операцию",
user_id INT UNSIGNED NOT NULL COMMENT "Ссылка на пользователя",
created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки", 
PRIMARY KEY (operation_id, user_id) COMMENT "Составной первичный ключ"
) COMMENT "Операции пользователей, связь между пользователями и совершенными ими операциями";

-- 6. таблица платежей
DROP TABLE IF EXISTS payments;
CREATE TABLE payments (
id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки", 
user_id INT UNSIGNED NOT NULL COMMENT "Ссылка на пользователя",
payment_type_id INT UNSIGNED NOT NULL COMMENT "Ссылка на тип платежа",
amount INT NOT NULL COMMENT "Сумма платежа",
created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки"
) COMMENT "Операции";

-- 7. таблица типов платежей
DROP TABLE IF EXISTS payment_types;
CREATE TABLE payment_types (
id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки", 
name VARCHAR(255) NOT NULL UNIQUE COMMENT "Название типа платежа"
) COMMENT "Типы платежей";

-- 8. таблица бонусных карт
DROP TABLE IF EXISTS bonus_cards;
CREATE TABLE bonus_cards (
id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки", 
name VARCHAR(255) NOT NULL UNIQUE COMMENT "Название бонусной карты"
) COMMENT "Бонусные карты";

-- 9. таблица рассылок
DROP TABLE IF EXISTS mailing;
CREATE TABLE mailing (
id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки", 
name VARCHAR(255) NOT NULL UNIQUE COMMENT "Название рассылки"
) COMMENT "Рассылки";

-- 10. таблица связи рассылок и пользователей
DROP TABLE IF EXISTS mailing_users;
CREATE TABLE mailing_users (
mailing_id INT UNSIGNED NOT NULL COMMENT "Ссылка на рассылку",
user_id INT UNSIGNED NOT NULL COMMENT "Ссылка на пользователя",
created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки", 
PRIMARY KEY (mailing_id, user_id) COMMENT "Составной первичный ключ"
) COMMENT "Рассылки пользователей, связь между пользователями и рассылками, на которые они подписаны";

-- 11. таблица книг
DROP TABLE IF EXISTS books;
CREATE TABLE books (
id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки",
name VARCHAR(255) NOT NULL UNIQUE COMMENT "Название книги",
author_id INT UNSIGNED NOT NULL COMMENT "Ссылка на автора книги",
series_id INT UNSIGNED NOT NULL COMMENT "Ссылка на серию книг",
genre_id INT UNSIGNED NOT NULL COMMENT "Ссылка на жанр книги",
about TEXT NOT NULL COMMENT "Аннотация к книге",
rating_LitRes FLOAT NOT NULL COMMENT "Рейтинг книги на ЛитРес",
rating_LiveLib FLOAT NOT NULL COMMENT "Рейтинг книги на LiveLib",
book_type_id INT UNSIGNED NOT NULL COMMENT "Ссылка на формат книги",
reviews_amount INT NOT NULL COMMENT "Количество отзывов",
price INT NOT NULL COMMENT "Цена",
created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Книги";

-- 12. таблица авторов
DROP TABLE IF EXISTS authors;
CREATE TABLE authors (
id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки", 
first_name VARCHAR(100) NOT NULL COMMENT "Имя автора",
last_name VARCHAR(100) NOT NULL COMMENT "Фамилия автора",
books_amount INT NOT NULL COMMENT "Количество книг",
about TEXT NOT NULL COMMENT "Информация об авторе",
reviews_amount INT NOT NULL COMMENT "Количество отзывов",
created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Авторы";

-- 13. таблица серий книг
DROP TABLE IF EXISTS series;
CREATE TABLE series (
id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки", 
name VARCHAR(255) NOT NULL UNIQUE COMMENT "Название серии книг"
) COMMENT "Серии книг";

-- 14. таблица жанров
DROP TABLE IF EXISTS genres;
CREATE TABLE genres (
id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки", 
name VARCHAR(255) NOT NULL UNIQUE COMMENT "Название жанра",
genre_group_id INT UNSIGNED NOT NULL COMMENT "Ссылка на группу жанров"
) COMMENT "Жанры";

-- 15. таблица групп жанров
DROP TABLE IF EXISTS genre_groups;
CREATE TABLE genre_groups (
id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки", 
name VARCHAR(255) NOT NULL UNIQUE COMMENT "Название группы жанров"
) COMMENT "Группы жанров";

-- 16. таблица типов книг
DROP TABLE IF EXISTS book_types;
CREATE TABLE book_types (
id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки", 
name VARCHAR(255) NOT NULL UNIQUE COMMENT "Формат книги"
) COMMENT "Типы книг";

-- 17. таблица рейтинга книг
DROP TABLE IF EXISTS litres_ratings;
CREATE TABLE litres_ratings (
book_id INT UNSIGNED NOT NULL COMMENT "Ссылка на книгу",
user_id INT UNSIGNED NOT NULL COMMENT "Ссылка на пользователя, поставившего оценку",
rating INT NOT NULL COMMENT "Оценка книги",
created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
);

-- 18. таблица тегов
DROP TABLE IF EXISTS tegs;
CREATE TABLE tegs (
id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки", 
name VARCHAR(255) NOT NULL UNIQUE COMMENT "Название тега"
) COMMENT "Теги";

-- 19. таблица связи тегов и книг
DROP TABLE IF EXISTS tegs_books;
CREATE TABLE tegs_books (
teg_id INT UNSIGNED NOT NULL COMMENT "Ссылка на рассылку",
book_id INT UNSIGNED NOT NULL COMMENT "Ссылка на пользователя",
created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки", 
PRIMARY KEY (teg_id, book_id) COMMENT "Составной первичный ключ"
) COMMENT "Теги книг, связь между тегами и книгами";

-- 20. таблица отзывов
DROP TABLE IF EXISTS reviews;
CREATE TABLE reviews (
id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки", 
user_id INT UNSIGNED NOT NULL COMMENT "Ссылка на пользователя",
body TEXT NOT NULL COMMENT "Текст отзыва",
likes_amount INT NOT NULL COMMENT "Количество лайков",
dislikes_amount INT NOT NULL COMMENT "Количество дислайков",
target_id INT UNSIGNED NOT NULL COMMENT "Ссылка на номер строки в таблице",
target_type_id INT UNSIGNED NOT NULL COMMENT "Ссылка на тип отзыва",
created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки"
) COMMENT "Отзывы"; 

-- 21. таблица типов отзывов
DROP TABLE IF EXISTS target_types;
CREATE TABLE target_types (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL UNIQUE,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- 22. таблица связи пользователей и книг
DROP TABLE IF EXISTS books_users;
CREATE TABLE books_users (
book_id INT UNSIGNED NOT NULL COMMENT "Ссылка на книгу",
user_id INT UNSIGNED NOT NULL COMMENT "Ссылка на пользователя",
created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки", 
PRIMARY KEY (book_id, user_id) COMMENT "Составной первичный ключ"
) COMMENT "Книги пользователей, связь между пользователями и книгами";

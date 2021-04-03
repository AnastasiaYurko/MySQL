-- выбираем базу данных и смотрим таблицы
USE vk;
SHOW TABLES;

-- исправляем недочеты в таблице users
SELECT * FROM users LIMIT 10;
UPDATE users SET updated_at = now() WHERE updated_at < created_at;

-- исправляем недочеты в таблице profiles
SELECT * FROM profiles LIMIT 10;
UPDATE profiles SET updated_at = now() WHERE updated_at < created_at;

-- исправляем недочеты в таблице messages
SELECT * FROM messages LIMIT 10;
UPDATE messages SET from_user_id = FLOOR(1 + RAND() * 100);
UPDATE messages SET to_user_id = FLOOR(1 + RAND() * 100);

-- исправляем недочеты в таблице media
SELECT * FROM media LIMIT 10;
UPDATE media SET user_id = FLOOR(1 + RAND() * 100);
UPDATE media SET updated_at = now() WHERE updated_at < created_at;

CREATE TEMPORARY TABLE extentions(name VARCHAR(10));
INSERT INTO extentions VALUES ('pdf'), ('jpeg'), ('avi'), ('mp3'), ('mp4');
SELECT * FROM extentions;

UPDATE media SET filename = CONCAT('https://onedrive.live.com/vk/', 
	filename, '.', (SELECT name FROM extentions ORDER BY RAND() LIMIT 1));
UPDATE media SET size = FLOOR(1 + RAND() * 1000000) WHERE size < 10000;
UPDATE media SET metadata = CONCAT('{"owner":"', 
	(SELECT CONCAT(first_name, ' ', last_name) 
    FROM users WHERE id = user_id),'"}');  
UPDATE media SET media_type_id = FLOOR(1 + RAND() * 3);

-- исправляем недочеты в таблице media_types
SELECT * FROM media_types;
TRUNCATE media_types;
INSERT INTO media_types (name) VALUES ('photo'), ('audio'), ('video');

-- исправляем недочеты в таблице friendship
SELECT * FROM friendship LIMIT 10;
UPDATE friendship SET user_id = FLOOR(1 + RAND() * 100);
UPDATE friendship SET friend_id = FLOOR(1 + RAND() * 100);
UPDATE friendship SET friendship_status_id = FLOOR(1 + RAND() * 3);
UPDATE friendship SET confirmed_at = now() WHERE confirmed_at < requested_at;

-- исправляем недочеты в таблице friendship_statuses
SELECT * FROM friendship_statuses;
TRUNCATE friendship_statuses;
INSERT INTO friendship_statuses (name) VALUES ('Requested'), ('Confirmed'), ('Rejected');

-- исправляем недочеты в таблице communities
SELECT * FROM communities;
DELETE FROM communities WHERE id > 30;

-- исправляем недочеты в таблице communities_users
SELECT * FROM communities_users;
UPDATE communities_users SET community_id = FLOOR(1 + RAND() * 30);

-- 3. Определить кто больше поставил лайков (всего) - мужчины или женщины?

SELECT
	(SELECT gender FROM profiles WHERE user_id = likes.user_id) AS gender,
		COUNT(*) AS total FROM likes GROUP BY gender ORDER BY total DESC;  

-- 4. Подсчитать общее количество лайков десяти самым молодым пользователям (сколько лайков получили 10 самых молодых пользователей).

SELECT COUNT(*) AS total_likes FROM likes WHERE target_type_id = 2 AND target_id IN 
	(SELECT * FROM (SELECT user_id FROM profiles ORDER BY birthday DESC LIMIT 10) AS sorted_profiles);

-- 5. Найти 10 пользователей, которые проявляют наименьшую активность в использовании социальной сети
-- (критерии активности необходимо определить самостоятельно).

SELECT 
  CONCAT(first_name, ' ', last_name) AS user, 
	(SELECT COUNT(*) FROM likes WHERE likes.user_id = users.id) + 
	(SELECT COUNT(*) FROM friendship WHERE friendship.user_id = users.id) + 
	(SELECT COUNT(*) FROM messages WHERE messages.from_user_id = users.id) +
    (SELECT COUNT(*) FROM media WHERE media.user_id = users.id) + 
    (SELECT COUNT(*) FROM posts WHERE posts.user_id = users.id) AS low_activity 
	  FROM users
	  ORDER BY low_activity
	  LIMIT 10;

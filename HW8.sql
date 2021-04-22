-- 3. Определить кто больше поставил лайков (всего) - мужчины или женщины?

 SELECT profiles.gender, COUNT(*) AS total FROM likes 
JOIN profiles ON likes.user_id = profiles.user_id GROUP BY profiles.gender ORDER BY total DESC;

-- 4. Подсчитать общее количество лайков десяти самым молодым пользователям (сколько лайков получили 10 самых молодых пользователей).

SELECT SUM(total) AS likes_sum FROM (SELECT profiles.user_id, profiles.birthday, COUNT(*) AS total FROM likes
JOIN profiles ON likes.user_id = profiles.user_id AND likes.target_type_id = 2 GROUP BY profiles.user_id 
ORDER BY profiles.birthday DESC LIMIT 10) AS young_users;

-- 5. Найти 10 пользователей, которые проявляют наименьшую активность в использовании социальной сети
-- (критерии активности необходимо определить самостоятельно).

SELECT users.id, COUNT(DISTINCT likes.id) + COUNT(DISTINCT friendship.user_id) + COUNT(DISTINCT messages.id) +
COUNT(DISTINCT media.id) + COUNT(DISTINCT posts.id) AS low_activity FROM users LEFT JOIN likes ON users.id = likes.user_id 
LEFT JOIN friendship ON friendship.user_id = users.id LEFT JOIN messages ON users.id = messages.from_user_id
LEFT JOIN media ON users.id = media.user_id LEFT JOIN posts ON posts.user_id = users.id
GROUP BY users.id ORDER BY low_activity LIMIT 10;


-- 1. Проанализировать какие запросы могут выполняться наиболее часто в процессе работы приложения и добавить необходимые индексы.

CREATE INDEX profiles_gender_birthday_idx ON profiles(gender, birthday);

/* 2. Задание на оконные функции. Построить запрос, который будет выводить следующие столбцы: имя группы; среднее количество пользователей в группах; самый молодой пользователь в группе;
самый старший пользователь в группе; общее количество пользователей в группе; всего пользователей в системе; отношение в процентах
(общее количество пользователей в группе / всего пользователей в системе) * 100.*/
 
SELECT DISTINCT communities.name,
 AVG(communities_users.user_id) OVER(PARTITION BY communities_users.community_id) AS average,
 COUNT(communities_users.user_id) OVER(PARTITION BY communities_users.community_id) AS total_by_group,
 COUNT(communities_users.user_id) OVER() AS total,
 COUNT(communities_users.user_id) OVER(PARTITION BY communities_users.community_id) / SUM(communities_users.user_id) OVER() * 100 AS "%%"
   FROM communities
     JOIN communities_users
       ON communities.id = communities_users.community_id;
      
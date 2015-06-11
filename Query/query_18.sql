CREATE TEMP TABLE idCITY as
SELECT cat.business_id, cat.city FROM "Progetto"."business-categories" as cat
UNION 
SELECT ope.business_id, ope.city FROM "Progetto"."business-openhours" as ope 
UNION
SELECT nei.business_id, nei.city FROM "Progetto"."business-neighborhoods" as nei
GROUP BY business_id, city;

CREATE TEMP TABLE tmp as
SELECT DISTINCT a.user_id as id, b.city as city
FROM "Progetto"."review-votes" as a, idCITY as b
WHERE a.business_id = b.business_id
GROUP BY a.user_id, b.city
ORDER BY id;

SELECT t1.id as user_id, t2.id as suggested_user_id
FROM tmp as t1 INNER JOIN tmp as t2 ON(t1.city = t2.city)
WHERE t1.id <> t2.id AND (t1.id, t2.id) NOT IN (SELECT f.user_id, f.friend_id FROM "Progetto"."user-friends" as f)
		     AND (t2.id, t1.id) NOT IN (SELECT f.user_id, f.friend_id FROM "Progetto"."user-friends" as f)


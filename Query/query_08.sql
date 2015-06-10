SELECT d.cit, d.cat
FROM (SELECT a.city as cit, a.category as cat, count(*) as num
	FROM "Progetto"."business-categories" AS a
	WHERE a.open = 'True'
	GROUP BY a.city, a.category) AS d
WHERE d.num < 5
CREATE TEMP TABLE tmp
ON COMMIT DROP as
SELECT DISTINCT business_id, user_id, text_id, stars as stelle, date
FROM "Progetto"."review-votes";

CREATE TEMP TABLE busStars
ON COMMIT DROP as
SELECT DISTINCT business_id, stars
FROM "Progetto"."business-categories";

CREATE TEMP TABLE numRev
ON COMMIT DROP as
SELECT user_id, count(text_id) as Tot
FROM tmp
GROUP BY user_id
HAVING count(text_id) >= 10;

CREATE TEMP TABLE numRevNeg
ON COMMIT DROP as
SELECT user_id, count(text_id) as Neg
FROM tmp NATURAL JOIN busStars
WHERE stelle < stars
GROUP BY user_id;


SELECT user_id, neg, Tot
FROM numRev NATURAL JOIN numRevNeg
WHERE neg >= ((tot/4)*3);
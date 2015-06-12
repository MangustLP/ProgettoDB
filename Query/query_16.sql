CREATE TEMP TABLE bidRev as
SELECT b.business_id as business_id, b.review_count as count
FROM "Progetto"."business-categories" as b
GROUP BY b.business_id, b.review_count
ORDER BY -b.review_count, b.business_id;

CREATE TEMP TABLE userBusTop as
SELECT x.user_id, x.business_id
FROM ((SELECT k.user_id, k.business_id 
       FROM "Progetto"."review-votes" as k) as o
       NATURAL JOIN (SELECT a.business_id
		     FROM bidRev as a
		     LIMIT ((SELECT count(a.business_id)/10 FROM bidRev as a))) as p) as x
GROUP BY x.user_id, x.business_id;


SELECT e.user_id
FROM (SELECT ubt.user_id, count(ubt.business_id) as co
      FROM userBusTop as ubt
      GROUP BY ubt.user_id
      ORDER BY -count(ubt.business_id)) as e
WHERE e.co >= (SELECT (count(ub.business_id)/4)*3
	       FROM (SELECT u.business_id FROM userBusTop as u GROUP BY u.business_id) as ub);

DROP TABLE bidRev;
DROP TABLE userBusTop;
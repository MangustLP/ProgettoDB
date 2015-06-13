SELECT DISTINCT B1.business_id ,B1.review_count, B1.stars, B1.city, B2.business_id as business_id2,B2.review_count as review_count2, B2.stars as stars2, B2.city as city2

FROM (SELECT *

      FROM "Progetto"."business-categories" 

      WHERE "Progetto"."business-categories".open = 'True') as B1 INNER JOIN (SELECT *

									      FROM "Progetto"."business-categories"

									      WHERE "Progetto"."business-categories".open = 'True') as B2 ON B1.category =  B2.category

WHERE B1.city <> B2.city AND B2.review_count < B1.review_count AND B2.stars < B1.stars

					


CREATE TABLE "Progetto"."business-categories-tmp"
(
	record_type character(8),
	business_id character(22),
	name character(100),
	full_address text,
	city character(20),	
	state character(3),
	stars real,
	reiew_count integer,
	open boolean,
	category character(50)
)

COPY "Progetto"."business-categories-tmp"
FROM '/tmp/dati/business-categories.csv'
WITH DELIMITER ','
CSV HEADER

CREATE TABLE "Progetto"."business-neighborhoods-tmp"
(
	record_type character(8),
	business_id character(22),
	name character(100),
	city character(20),
	state character(3),
	latitude double precision,
	longitude double precision,
	neighborhood character(30)
)

COPY "Progetto"."business-neighborhoods-tmp"
FROM '/tmp/dati/business-neighborhoods.csv'
WITH DELIMITER ','
CSV HEADER

CREATE TABLE "Progetto"."business-openhours-tmp"
(
	record_type character(10),
	business_id character(22) NOT NULL,
	name character(100),
	full_address text,
	city character(20),
	state character(3),
	open boolean,
	day character(9) NOT NULL,
	opens time without time zone,
	closes time without time zone
)

COPY "Progetto"."business-openhours-tmp"
FROM '/tmp/dati/business-openhours.csv'
WITH DELIMITER ','
CSV HEADER

CREATE TABLE "Progetto"."review-votes-tmp"
(
	record_type character(6),
	business_id character(22),
	user_id character(22),
	stars smallint,
	text text,
	date date,
	vote_type character(100),
	count smallint
)

COPY "Progetto"."review-votes-tmp"
FROM '/tmp/dati/review-votes.csv'
WITH DELIMITER ','
CSV HEADER

CREATE TABLE "Progetto"."user-profiles-tmp"
(
	record_type character(4),
	user_id character(22),
	name character(30),
	review_count smallint,
	average_stars real,
	registered_on character(7),
	fans_count integer,
	elite_years_count smallint
)

COPY "Progetto"."user-profiles-tmp"
FROM '/tmp/dati/user-profiles.csv'
WITH DELIMITER ','
CSV HEADER

CREATE TABLE "Progetto"."user-votes-tmp"
(
	record_type character(9),
	user_id character(22),
	name character(30),
	vote_type character(20),
	count smallint
)

COPY "Progetto"."user-votes-tmp"
FROM '/tmp/dati/user-votes.csv'
WITH DELIMITER ','
CSV HEADER

CREATE TABLE "Progetto"."user-friends-tmp"
(
	record_type character(6),
	user_id character(22),
	name character(30),
	friend_id character(22)
)

COPY "Progetto"."user-friends-tmp"
FROM '/tmp/dati/user-friends.csv'
WITH DELIMITER ','
CSV HEADER

CREATE TABLE "Progetto"."user-compliments-tmp"
(
	record_type character(10),
	user_id character(22),
	name character(30),
	compliment_type character(20),
	num_compliments_of_this_type smallint
)

COPY "Progetto"."user-compliments-tmp"
FROM '/tmp/dati/user-compliments.csv'
WITH DELIMITER ','
CSV HEADER

COPY "Progetto"."business-position"
FROM (SELECT business_id, full_address, city, state, latitude, longitude, neighborhood
	  FROM "business-openhours-tmp" NATURAL JOIN "business-neighborhoods-tmp")

COPY "Progetto"."business-openhours"
FROM (SELECT business_id, name, open, day, opens, closes
	  FROM "business-openhours-tmp")

COPY "Progetto"."business-categories"
FROM (SELECT business_id, stars, review_count, category
	  FROM "business-categories-tmp")

COPY "Progetto"."user-friends"
FROM (SELECT user_id, friend_id
	  FROM "user-friends")

COPY "Progetto"."user-compliments"
FROM (SELECT user_id, compliment_type, num_compliment
	  FROM "user-compliments-tmp")

COPY "Progetto"."reviews"
FROM (SELECT "text"
	  FROM "review-votes-tmp")

COPY "Progetto"."user-profiles"
FROM (SELECT user_id, name, review_count, average_stars, registered_on, fans_count, elite_years_count
	  FROM "user-profiles-tmp")

COPY "Progetto"."user-votes"
FROM (SELECT user_id, vote_type, count
	  FROM "user-votes-tmp")

COPY "Progetto"."review-votes"
FROM (SELECT business_id, user_id, stars, id, date, vote_type, count
	  FROM "review-votes-tmp" NATURAL JOIN "reviews" as a)

DROP TABLE "business-categories-tmp"
DROP TABLE "business-neighborhoods-tmp"
DROP TABLE "business-openhours-tmp"
DROP TABLE "review-votes-tmp"
DROP TABLE "user-profiles-tmp"
DROP TABLE "user-friends-tmp"
DROP TABLE "user-compliments-tmp"
DROP TABLE "user-votes-tmp"
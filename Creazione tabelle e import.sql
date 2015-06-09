CREATE TABLE "Progetto"."business-categories-tmp"
(
	record_type character(8),
	business_id character(22),
	name character(100),
	full_address text,
	city character(20),	
	state character(3),
	stars real,
	review_count integer,
	open boolean,
	category character(50)
);

COPY "Progetto"."business-categories-tmp"
FROM '/tmp/dati/business-categories.csv'
WITH DELIMITER ','
CSV HEADER;

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
);

COPY "Progetto"."business-neighborhoods-tmp"
FROM '/tmp/dati/business-neighborhoods.csv'
WITH DELIMITER ','
CSV HEADER;

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
);

COPY "Progetto"."business-openhours-tmp"
FROM '/tmp/dati/business-openhours.csv'
WITH DELIMITER ','
CSV HEADER;

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
);

COPY "Progetto"."review-votes-tmp"
FROM '/tmp/dati/review-votes.csv'
WITH DELIMITER ','
CSV HEADER;

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
);

COPY "Progetto"."user-profiles-tmp"
FROM '/tmp/dati/user-profiles.csv'
WITH DELIMITER ','
CSV HEADER;

CREATE TABLE "Progetto"."user-votes-tmp"
(
	record_type character(9),
	user_id character(22),
	name character(30),
	vote_type character(20),
	count smallint
);

COPY "Progetto"."user-votes-tmp"
FROM '/tmp/dati/user-votes.csv'
WITH DELIMITER ','
CSV HEADER;

CREATE TABLE "Progetto"."user-friends-tmp"
(
	record_type character(6),
	user_id character(22),
	name character(30),
	friend_id character(22)
);

COPY "Progetto"."user-friends-tmp"
FROM '/tmp/dati/user-friends.csv'
WITH DELIMITER ','
CSV HEADER;

CREATE TABLE "Progetto"."user-compliments-tmp"
(
	record_type character(10),
	user_id character(22),
	name character(30),
	compliment_type character(20),
	num_compliments_of_this_type smallint
);

COPY "Progetto"."user-compliments-tmp"
FROM '/tmp/dati/user-compliments.csv'
WITH DELIMITER ','
CSV HEADER;

INSERT INTO "Progetto"."business-position"
SELECT "Progetto"."business-openhours-tmp".business_id, full_address, "Progetto"."business-openhours-tmp".city, "Progetto"."business-openhours-tmp".state, latitude, longitude, neighborhood
	  FROM "Progetto"."business-openhours-tmp" INNER JOIN "Progetto"."business-neighborhoods-tmp" ON ("Progetto"."business-openhours-tmp".business_id = "Progetto"."business-neighborhoods-tmp".business_id)
	  GROUP BY "Progetto"."business-openhours-tmp".business_id, full_address, "Progetto"."business-openhours-tmp".city, "Progetto"."business-openhours-tmp".state, latitude, longitude, neighborhood;

INSERT INTO "Progetto"."business-openhours"
SELECT business_id, name, open, day, opens, closes
	  FROM "Progetto"."business-openhours-tmp";

INSERT INTO "Progetto"."business-categories"
SELECT business_id, stars, review_count, category
	  FROM "Progetto"."business-categories-tmp";

INSERT INTO "Progetto"."user-friends"
SELECT user_id, friend_id
	  FROM "Progetto"."user-friends-tmp";

INSERT INTO "Progetto"."user-compliments"
SELECT user_id, compliment_type, num_compliments_of_this_type
	  FROM "Progetto"."user-compliments-tmp";

INSERT INTO "Progetto"."reviews"(text)
SELECT text
	  FROM "Progetto"."review-votes-tmp"
	  GROUP BY text;

INSERT INTO "Progetto"."user-pofiles"
SELECT user_id, name, review_count, average_stars, registered_on, fans_count, elite_years_count
	  FROM "Progetto"."user-profiles-tmp";

INSERT INTO "Progetto"."user-votes"
SELECT user_id, vote_type, count
	  FROM "Progetto"."user-votes-tmp";

INSERT INTO "Progetto"."review-votes"
SELECT business_id, user_id, stars, id, date, vote_type, count
	  FROM "Progetto"."review-votes-tmp" NATURAL JOIN "Progetto"."reviews" as a;

DROP TABLE "Progetto"."business-categories-tmp";
DROP TABLE "Progetto"."business-neighborhoods-tmp";
DROP TABLE "Progetto"."business-openhours-tmp";
DROP TABLE "Progetto"."review-votes-tmp";
DROP TABLE "Progetto"."user-profiles-tmp";
DROP TABLE "Progetto"."user-friends-tmp";
DROP TABLE "Progetto"."user-compliments-tmp";
DROP TABLE "Progetto"."user-votes-tmp";
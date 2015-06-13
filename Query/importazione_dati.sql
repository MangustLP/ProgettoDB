CREATE TABLE "Progetto"."business-categories-tmp"
(
	record_type character(8),
	business_id character(22),
	name varchar(100),
	full_address varchar(400),
	city varchar(20),
	state varchar(3),
	stars real,
	review_count integer,
	open varchar(5),
	category varchar(50)
);

COPY "Progetto"."business-categories-tmp"
FROM '/tmp/dati/business-categories.csv'
WITH DELIMITER ','
CSV HEADER;

CREATE TABLE "Progetto"."business-neighborhoods-tmp"
(
	record_type character(8),
	business_id character(22),
	name varchar(100),
	city varchar(20),
	state varchar(3),
	latitude double precision,
	longitude double precision,
	neighborhood varchar(30)
);

COPY "Progetto"."business-neighborhoods-tmp"
FROM '/tmp/dati/business-neighborhoods.csv'
WITH DELIMITER ','
CSV HEADER;

CREATE TABLE "Progetto"."business-openhours-tmp"
(
	record_type character(10),
	business_id character(22),
	name varchar(100),
	full_address varchar(400),
	city varchar(20),
	state varchar(3),
	open varchar(5),
	day varchar(9),
	opens character(5),
	closes character(5)
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
	text varchar(5000),
	date date,
	vote_type varchar(10),
	count integer
);

COPY "Progetto"."review-votes-tmp"
FROM '/tmp/dati/review-votes.csv'
WITH DELIMITER ','
CSV HEADER;

CREATE TABLE "Progetto"."user-profiles-tmp"
(
	record_type character(4),
	user_id character(22),
	name varchar(30),
	review_count smallint,
	average_stars real,
	registered_on varchar(7),
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
	name varchar(30),
	vote_type varchar(10),
	count integer
);

COPY "Progetto"."user-votes-tmp"
FROM '/tmp/dati/user-votes.csv'
WITH DELIMITER ','
CSV HEADER;

CREATE TABLE "Progetto"."user-friends-tmp"
(
	record_type character(6),
	user_id character(22),
	name varchar(30),
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
	name varchar(30),
	compliment_type varchar(10),
	num_compliments_of_this_type integer
);

COPY "Progetto"."user-compliments-tmp"
FROM '/tmp/dati/user-compliments.csv'
WITH DELIMITER ','
CSV HEADER;

INSERT INTO "Progetto"."business-neighborhoods"
SELECT business_id, name, city, state, latitude, longitude, neighborhood
	  FROM "Progetto"."business-neighborhoods-tmp";

INSERT INTO "Progetto"."business-openhours"
SELECT business_id, name, full_address, city, state, open, day, opens, closes
	  FROM "Progetto"."business-openhours-tmp";

INSERT INTO "Progetto"."business-categories"
SELECT business_id, name, full_address, city, state, stars, review_count, open, category
	  FROM "Progetto"."business-categories-tmp";

INSERT INTO "Progetto"."user-friends"
SELECT user_id, friend_id
	  FROM "Progetto"."user-friends-tmp";

INSERT INTO "Progetto"."user-compliments"
SELECT user_id, compliment_type, num_compliments_of_this_type
	  FROM "Progetto"."user-compliments-tmp";

INSERT INTO "Progetto"."reviews"(text)
SELECT DISTINCT text
	  FROM "Progetto"."review-votes-tmp";

INSERT INTO "Progetto"."user-profiles"
SELECT user_id, name, review_count, average_stars, registered_on, fans_count, elite_years_count
	  FROM "Progetto"."user-profiles-tmp";

INSERT INTO "Progetto"."user-votes"
SELECT user_id, vote_type, count
	  FROM "Progetto"."user-votes-tmp";

INSERT INTO "Progetto"."review-votes"
SELECT business_id, user_id, stars, id, date, vote_type, count
	  FROM "Progetto"."review-votes-tmp" INNER JOIN "Progetto"."reviews" ON ("Progetto"."review-votes-tmp".text = "Progetto"."reviews".text);

DROP TABLE "Progetto"."business-categories-tmp";
DROP TABLE "Progetto"."business-neighborhoods-tmp";
DROP TABLE "Progetto"."business-openhours-tmp";
DROP TABLE "Progetto"."review-votes-tmp";
DROP TABLE "Progetto"."user-profiles-tmp";
DROP TABLE "Progetto"."user-friends-tmp";
DROP TABLE "Progetto"."user-compliments-tmp";
DROP TABLE "Progetto"."user-votes-tmp";
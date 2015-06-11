CREATE TABLE "Progetto"."business-categories-tmp"
(
	record_type character(8) DEFAULT 'category',
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

INSERT INTO "Progetto"."business-categories-tmp"(business_id, name, full_address, city, state, stars, review_count, open, category)
SELECT DISTINCT business_id, name, full_address, city, state, stars, review_count, open, category
	  FROM "Progetto"."business-categories";

CREATE TABLE "Progetto"."business-neighborhoods-tmp"
(
	record_type character(8) DEFAULT 'location',
	business_id character(22),
	name varchar(100),
	city varchar(20),
	state varchar(3),
	latitude double precision,
	longitude double precision,
	neighborhood varchar(30)
);

INSERT INTO "Progetto"."business-neighborhoods-tmp" (business_id, name, city, state, latitude, longitude, neighborhood)
SELECT DISTINCT business_id, name, city, state, latitude, longitude, neighborhood
	   FROM "Progetto"."business-neighborhoods";

CREATE TABLE "Progetto"."business-openhours-tmp"
(
	record_type character(10) DEFAULT 'open-hours',
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

INSERT INTO "Progetto"."business-openhours-tmp" (business_id, name, full_address, city, state, open, day, opens, closes)
SELECT DISTINCT business_id, name, full_address, city, state, open, day, opens, closes
	   FROM "Progetto"."business-openhours";

CREATE TABLE "Progetto"."review-votes-tmp"
(
	record_type character(6) DEFAULT 'review',
	business_id character(22),
	user_id character(22),
	stars smallint,
	text varchar(5000),
	date date,
	vote_type varchar(10),
	count integer
);

INSERT INTO "Progetto"."review-votes-tmp" (business_id, user_id, stars, text, date, vote_type, count)
SELECT business_id, user_id, stars, text, date, vote_type, count
	   FROM "Progetto"."review-votes" INNER JOIN "Progetto"."reviews" ON ("Progetto"."review-votes".text_id = "Progetto"."reviews".id);

CREATE TABLE "Progetto"."user-profiles-tmp"
(
	record_type character(4) DEFAULT 'user',
	user_id character(22),
	name varchar(30),
	review_count smallint,
	average_stars real,
	registered_on varchar(7),
	fans_count integer,
	elite_years_count smallint
);

INSERT INTO "Progetto"."user-profiles-tmp"(user_id, name, review_count, average_stars, registered_on, fans_count, elite_years_count)
SELECT user_id, name, review_count, average_stars, registered_on, fans_count, elite_years_count
	   FROM "Progetto"."user-profiles";

CREATE TABLE "Progetto"."user-votes-tmp"
(
	record_type character(9) DEFAULT 'user-vote',
	user_id character(22),
	name varchar(30),
	vote_type varchar(10),
	count integer
);

INSERT INTO "Progetto"."user-votes-tmp" (user_id, name, vote_type, count)
SELECT user_id, name, vote_type, count
	   FROM "Progetto"."user-votes" NATURAL JOIN "Progetto"."user-profiles";

CREATE TABLE "Progetto"."user-friends-tmp"
(
	record_type character(6) DEFAULT 'friend',
	user_id character(22),
	name varchar(30),
	friend_id character(22)
);

INSERT INTO "Progetto"."user-friends-tmp" (user_id, name, friend_id)
SELECT user_id, name, friend_id
	   FROM "Progetto"."user-friends" NATURAL JOIN "Progetto"."user-profiles";


CREATE TABLE "Progetto"."user-compliments-tmp"
(
	record_type character(10),
	user_id character(22),
	name varchar(30),
	compliment_type varchar(10),
	num_compliments_of_this_type integer
);

INSERT INTO "Progetto"."user-compliments-tmp" (user_id, name, compliment_type, num_compliments_of_this_type)
SELECT user_id, name, compliment_type, num_compliments_of_this_type
	   FROM "Progetto"."user-compliments" NATURAL JOIN "Progetto"."user-profiles";





COPY (SELECT *
      FROM "Progetto"."business-categories-tmp"
      ORDER BY business_id)
TO '/tmp/output/business-categories.csv'
WITH CSV
     DELIMITER ','
     HEADER
     QUOTE '"'
     FORCE QUOTE name, full_address, category;


COPY (SELECT *
	  FROM "Progetto"."business-neighborhoods-tmp"
	  ORDER BY business_id)
TO '/tmp/output/business-neighborhoods.csv'
WITH CSV
     DELIMITER ','
     HEADER
     QUOTE '"'
     FORCE QUOTE name, city, neighborhood;

COPY (SELECT *
	  FROM "Progetto"."business-openhours-tmp"
	  ORDER BY business_id)
TO '/tmp/output/business-openhours.csv'
WITH CSV
     DELIMITER ','
     HEADER
     QUOTE '"'
     FORCE QUOTE name, full_address;

COPY (SELECT *
	  FROM "Progetto"."review-votes-tmp"
	  ORDER BY business_id, user_id)
TO '/tmp/output/review-votes.csv'
WITH CSV
     DELIMITER ','
     HEADER
     QUOTE '"'
     FORCE QUOTE text;

COPY (SELECT *
	  FROM "Progetto"."user-profiles-tmp"
	  ORDER BY user_id)
TO '/tmp/output/user-profiles.csv'
WITH CSV
     DELIMITER ','
     HEADER
     QUOTE '"'
     FORCE QUOTE name;

COPY (SELECT *
	  FROM "Progetto"."user-votes-tmp"
	  ORDER BY user_id)
TO '/tmp/output/user-votes.csv'
WITH CSV
     DELIMITER ','
     HEADER;

COPY (SELECT *
	  FROM "Progetto"."user-friends-tmp"
	  ORDER BY user_id)
TO '/tmp/output/user-friends.csv'
WITH CSV
     DELIMITER ','
     HEADER;

COPY (SELECT *
	  FROM "Progetto"."user-compliments-tmp"
	  ORDER BY user_id)
TO '/tmp/output/user-compliments.csv'
WITH CSV
     DELIMITER ','
     HEADER;




DROP TABLE "Progetto"."business-categories-tmp";
DROP TABLE "Progetto"."business-neighborhoods-tmp";
DROP TABLE "Progetto"."business-openhours-tmp";
DROP TABLE "Progetto"."review-votes-tmp";
DROP TABLE "Progetto"."user-profiles-tmp";
DROP TABLE "Progetto"."user-friends-tmp";
DROP TABLE "Progetto"."user-compliments-tmp";
DROP TABLE "Progetto"."user-votes-tmp";
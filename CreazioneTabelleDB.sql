CREATE SCHEMA "Progetto"

CREATE TABLE "Progetto"."user-pofiles"
(
	user_id character(22),
	name character(25),
    review_count smallint,
    average_stars real,
    registered_on character(7),
    fans_count integer,
    elite_years_count smallint,
    PRIMARY KEY (user_id)
)

CREATE TABLE "Progetto"."user-friends"
(
	user_id character(22),
	friend_id character(22),
	PRIMARY KEY(user_id, friend_id)
)

CREATE TABLE "Progetto"."user-compliments"
(
	user_id character(22),
	compliment_type character(10),
	num_compliment integer,
	PRIMARY KEY(user_id, compliment_type)
)

CREATE TABLE "Progetto"."user-votes"
(
	user_id character(22),
	vote_type character(10),
	count integer,
	PRIMARY KEY(user_id, vote_type)
)

CREATE TABLE "Progetto"."review-votes"
(
	business_id character(22),
	user_id character(22),
	stars smallint,
	text_id integer,
	date date,
	vote_type character(10),
	count integer,
	PRIMARY KEY(business_id, user_id, text_id, vote_type)
)

CREATE TABLE "Progetto"."reviews"
(
	id SERIAL,
	text text,
	PRIMARY KEY(id)
)

CREATE TABLE "Progetto"."business-openhours"
(
	business_id	character(22),
	name character(60),
	open boolean,
	day	character(9),
	opens time without time zone,
	closes time without time zone,
	PRIMARY KEY(business_id, day)
)

CREATE TABLE "Progetto"."business-categories"
(
	business_id character(22),
	stars real,
	review_count integer,
	category character(40),
	PRIMARY KEY(business_id, category)
)

CREATE TABLE "Progetto"."business-position"
(
	business_id character(22),
	full_address character(150),
	city character(20),
	state character(3),
	latitude double precision,
	longitude double precision,
	neighborhood character(30),
	PRIMARY KEY(business_id, neighborhood)
)
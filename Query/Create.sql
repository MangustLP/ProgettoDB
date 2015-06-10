CREATE SCHEMA "Progetto"

CREATE TABLE "Progetto"."user-profiles"
(
	user_id character(22),
	name varchar(30),
    review_count smallint,
    average_stars real,
    registered_on varchar(7),
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
	compliment_type varchar(10),
	num_compliments_of_this_type integer,
	PRIMARY KEY(user_id, compliment_type)
)

CREATE TABLE "Progetto"."user-votes"
(
	user_id character(22),
	vote_type varchar(10),
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
	vote_type varchar(10),
	count integer
)

CREATE TABLE "Progetto"."reviews"
(
	id SERIAL,
	text varchar(5000),
	PRIMARY KEY(id)
)

CREATE TABLE "Progetto"."business-openhours"
(
	business_id character(22),
	day varchar(9),
	opens character(5),
	closes character(5),
	PRIMARY KEY(business_id, day)
);

CREATE TABLE "Progetto"."business-categories"
(
	business_id character(22),
	name varchar(100),
	full_address varchar(400),
	city varchar(20),
	state varchar(3),
	stars real,
	review_count integer,
	open varchar(5),
	category varchar(50),
	PRIMARY KEY(business_id, category)
);

CREATE TABLE "Progetto"."business-neighborhoods"
(
	business_id character(22),
	latitude double precision,
	longitude double precision,
	neighborhood varchar(30),
	PRIMARY KEY(business_id, neighborhood)
);
CREATE TABLE "Progetto"."user-friends"
(
  record_type character(6),
  user_id character(22) NOT NULL,
  name character(30),
  friend_id character(22) NOT NULL,
  CONSTRAINT "user-friends_pkey" PRIMARY KEY (user_id, friend_id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "Progetto"."user-friends"
  OWNER TO postgres;

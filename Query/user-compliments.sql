CREATE TABLE "Progetto"."user-compliments"
(
  record_type character(10),
  user_id character(22),
  name character(30),
  compliment_type character(20),
  num_compliments_of_this_type smallint,
  PRIMARY KEY (user_id, compliment_type)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "Progetto"."user-compliments"
  OWNER TO postgres;

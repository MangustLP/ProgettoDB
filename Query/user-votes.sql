CREATE TABLE "Progetto"."user-votes"
(
  record_type character(9),
  user_id character(22) NOT NULL,
  name character(30),
  vote_type character(20) NOT NULL,
  count smallint,
  CONSTRAINT "user-votes_pkey" PRIMARY KEY (user_id, vote_type)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "Progetto"."user-votes"
  OWNER TO postgres;

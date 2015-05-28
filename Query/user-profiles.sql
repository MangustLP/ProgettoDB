CREATE TABLE "Progetto"."user-profiles"
(
  record_type character(4),
  user_id character(22) NOT NULL,
  name character(30),
  review_count smallint,
  average_stars real,
  registered_on character(7),
  fans_count integer,
  elite_years_count smallint,
  CONSTRAINT "user-profiles_pkey" PRIMARY KEY (user_id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "Progetto"."user-profiles"
  OWNER TO postgres;

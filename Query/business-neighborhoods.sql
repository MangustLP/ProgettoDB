CREATE TABLE "Progetto"."business-neighborhoods"
(
  record_type character(8),
  business_id character(22) NOT NULL,
  name character(100),
  city character(20),
  state character(3),
  latitude double precision,
  longitude double precision,
  neighborhood character(30) NOT NULL,
  CONSTRAINT "business-neighborhoods_pkey" PRIMARY KEY (business_id, neighborhood)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "Progetto"."business-neighborhoods"
  OWNER TO postgres;

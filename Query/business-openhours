CREATE TABLE "Progetto"."business-openhours"
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
  closes time without time zone,
  CONSTRAINT "business-openhours_pkey" PRIMARY KEY (business_id, day)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "Progetto"."business-openhours"
  OWNER TO postgres;

CREATE TABLE "Progetto"."business-categories"
(
  record_type character(8),
  business_id character(22) NOT NULL,
  name character(100),
  full_address text,
  city character(20),
  state character(3),
  stars real,
  reiew_count integer,
  open boolean,
  category character(50) NOT NULL,
  CONSTRAINT business_categories_pkey PRIMARY KEY (business_id, category)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "Progetto"."business-categories"
  OWNER TO postgres;
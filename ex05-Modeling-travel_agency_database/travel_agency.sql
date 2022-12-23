CREATE DATABASE "travel_agency";

CREATE TABLE "companies"(
	"id" SERIAL PRIMARY KEY,
	"initials" VARCHAR(8) UNIQUE NOT NULL,
	"name" TEXT UNIQUE NOT NULL
);

CREATE TABLE "flights"(
	"id" SERIAL PRIMARY KEY,
	"flight_code" VARCHAR(8) UNIQUE NOT NULL,
	"company_id" INTEGER NOT NULL,
	"from_airport_id" INTEGER NOT NULL,
	"to_airport_id" INTEGER NOT NULL,
	"departure_time" TIMESTAMP WITHOUT TIME ZONE NOT NULL,
	"arrival_time" TIMESTAMP WITHOUT TIME ZONE NOT NULL
);

CREATE TABLE "airports"(
	"id" SERIAL PRIMARY KEY,
	"name" TEXT UNIQUE NOT NULL,
	"initials" VARCHAR(8) UNIQUE NOT NULL
);



ALTER TABLE "companies" ADD CONSTRAINT "chk_initials0" CHECK ("initials" ~ '^[A-Z\0-9]*$');

ALTER TABLE "flights" ADD CONSTRAINT "chk_f_code" CHECK ("flight_code" ~ '^[A-Z\0-9]*$');
ALTER TABLE "flights" ADD CONSTRAINT "c_id_fk0" FOREIGN KEY ("company_id") REFERENCES "companies"("id");
ALTER TABLE "flights" ADD CONSTRAINT "f_a_id_fk0" FOREIGN KEY ("from_airport_id") REFERENCES "airports"("id");
ALTER TABLE "flights" ADD CONSTRAINT "t_a_id_fk0" FOREIGN KEY ("to_airport_id") REFERENCES "airports"("id");

ALTER TABLE "airports" ADD CONSTRAINT "chk_initials0" CHECK ("initials" ~ '^[A-Z\0-9]*$');
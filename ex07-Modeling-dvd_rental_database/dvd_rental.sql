CREATE DATABASE "dvd_rental";

CREATE TABLE "clients"(
	"id" SERIAL NOT NULL PRIMARY KEY,
	"name" TEXT NOT NULL,
	"cpf" VARCHAR(11) UNIQUE NOT NULL
);

CREATE TABLE "phones"(
	"id" SERIAL NOT NULL PRIMARY KEY,
	"number" VARCHAR(11) UNIQUE NOT NULL
);

CREATE TABLE "clients_phones"(
	"id" SERIAL NOT NULL PRIMARY KEY,
	"client_id" INTEGER NOT NULL,
	"phone_id" INTEGER NOT NULL
);

CREATE TABLE "states"(
	"id" SERIAL NOT NULL PRIMARY KEY,
	"name" TEXT UNIQUE NOT NULL,
	"initials" VARCHAR(2) UNIQUE NOT NULL
);

CREATE TABLE "cities"(
	"id" SERIAL NOT NULL PRIMARY KEY,
	"name" TEXT NOT NULL,
	"state_id" INTEGER NOT NULL
);

CREATE TABLE "addresses"(
	"id" SERIAL NOT NULL PRIMARY KEY,
	"street" TEXT NOT NULL,
	"number" VARCHAR(10) NOT NULL,
	"zip_code" VARCHAR(8) NOT NULL,
	"district" TEXT NOT NULL,
	"city_id" INTEGER NOT NULL,
	"complement" TEXT DEFAULT(NULL)
);

CREATE TABLE "clients_addresses"(
	"id" SERIAL NOT NULL PRIMARY KEY,
	"client_id" INTEGER NOT NULL,
	"address_id" INTEGER NOT NULL
);

CREATE TABLE "countries"(
	"id" SERIAL NOT NULL PRIMARY KEY,
	"name" SERIAL UNIQUE NOT NULL
);

CREATE TABLE "actors"(
	"id" SERIAL NOT NULL PRIMARY KEY,
	"name" SERIAL UNIQUE NOT NULL,
	"birthdate" DATE NOT NULL,
	"country_id" INTEGER NOT NULL
);

CREATE TABLE "categories"(
	"id" SERIAL NOT NULL PRIMARY KEY,
	"name" TEXT UNIQUE NOT NULL
);

CREATE TABLE "dvds"(
	"id" SERIAL NOT NULL PRIMARY KEY,
	"bar_code" TEXT UNIQUE NOT NULL,
	"movie_name" TEXT UNIQUE NOT NULL,
	"category_id" INTEGER NOT NULL
);

CREATE TABLE "dvds_actors"(
	"id" SERIAL NOT NULL PRIMARY KEY,
	"dvd_id" INTEGER NOT NULL,
	"actor_id" INTEGER NOT NULL
);

CREATE TABLE "orders"(
	"id" SERIAL NOT NULL PRIMARY KEY,
	"client_id" INTEGER NOT NULL,
	"pick_up_date" DATE NOT NULL DEFAULT NOW(),
	"drop_off_date" DATE NOT NULL
);

CREATE TABLE "dvds_orders"(
	"id" SERIAL NOT NULL PRIMARY KEY,
	"dvd_id" INTEGER NOT NULL,
	"order_id" INTEGER NOT NULL
);

ALTER TABLE "clients" ADD CONSTRAINT "chk_cpf0" CHECK (LENGTH("cpf") = 11 ); 
ALTER TABLE "clients" ADD CONSTRAINT "chk_cpf1" CHECK ("cpf" ~ '^[0-9]*$');

ALTER TABLE "phones" ADD CONSTRAINT "chk_num0" CHECK (LENGTH("number") BETWEEN 10 AND 11 );
ALTER TABLE "phones" ADD CONSTRAINT "chk_num1" CHECK ("number" ~ '^[0-9]*$');

ALTER TABLE "clients_phones" ADD CONSTRAINT "fk0_cl_id" FOREIGN KEY ("client_id") REFERENCES "clients"("id");
ALTER TABLE "clients_phones" ADD CONSTRAINT "fk0_ph_id" FOREIGN KEY ("phone_id") REFERENCES "phones"("id");

ALTER TABLE "states" ADD CONSTRAINT "chk_initials0" CHECK (LENGTH("initials") = 2 ); 
ALTER TABLE "states" ADD CONSTRAINT "chk_initials1" CHECK ("initials" ~ '^[A-Z]*$' ); 

ALTER TABLE "cities" ADD CONSTRAINT "fk_s_id" FOREIGN KEY ("state_id") REFERENCES "states"("id");

ALTER TABLE "addresses" ADD CONSTRAINT "chk_zip0" CHECK (LENGTH("zip_code") = 8 );
ALTER TABLE "addresses" ADD CONSTRAINT "chk_zip1" CHECK ("zip_code" ~ '^[0-9]*$' );
ALTER TABLE "addresses" ADD CONSTRAINT "fk0_city_id" FOREIGN KEY ("city_id") REFERENCES "cities"("id");

ALTER TABLE "clients_addresses" ADD CONSTRAINT "fk0_c_id" FOREIGN KEY ("client_id") REFERENCES "clients"("id");
ALTER TABLE "clients_addresses" ADD CONSTRAINT "fk0_a_id" FOREIGN KEY ("address_id") REFERENCES "addresses"("id");

ALTER TABLE "actors" ADD CONSTRAINT "fk0_c_id" FOREIGN KEY ("country_id") REFERENCES "countries"("id");

ALTER TABLE "dvds" ADD CONSTRAINT "fk0_c_id" FOREIGN KEY ("category_id") REFERENCES "categories"("id");

ALTER TABLE "dvds_actors" ADD CONSTRAINT "fk0_dvd_id" FOREIGN KEY ("dvd_id") REFERENCES "countries"("id");
ALTER TABLE "dvds_actors" ADD CONSTRAINT "fk0_a_id" FOREIGN KEY ("actor_id") REFERENCES "actors"("id");

ALTER TABLE "orders" ADD CONSTRAINT "fk0_c_id" FOREIGN KEY ("client_id") REFERENCES "clients"("id");

ALTER TABLE "dvds_orders" ADD CONSTRAINT "fk0_dvd_id" FOREIGN KEY ("dvd_id") REFERENCES "dvds"("id");
ALTER TABLE "dvds_orders" ADD CONSTRAINT "fk0_ord_id" FOREIGN KEY ("order_id") REFERENCES "orders"("id");

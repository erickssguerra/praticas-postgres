CREATE DATABASE pratica_modelagem2;

CREATE TABLE customers(
	"id" SERIAL PRIMARY KEY,
	"fullName" VARCHAR(50) NOT NULL,
	"cpf" VARCHAR(11) UNIQUE NOT NULL,
	"email" TEXT UNIQUE NOT NULL,
	"password" TEXT NOT NULL
);

CREATE TABLE "customerAddresses"(
	"id" SERIAL PRIMARY KEY,
	"customerId" INTEGER NOT NULL,
	"street" VARCHAR(50) NOT NULL,
	"number" VARCHAR(10) NOT NULL,
	"complement" VARCHAR(50), -- there are addresses without complement
	"postalCode" VARCHAR(8) NOT NULL,
	"cityId" INTEGER NOT NULL
);

CREATE TABLE "customerPhones"(
	"id" SERIAL PRIMARY KEY,
	"customerId" INTEGER NOT NULL,
	"number" VARCHAR(11) NOT NULL, 
	"type" VARCHAR (10) NOT NULL
);

CREATE TABLE "cities"(
	"id" SERIAL PRIMARY KEY,
	"name" VARCHAR(30) NOT NULL,
	"stateId" INTEGER NOT NULL
);

CREATE TABLE "states"(
	"id" SERIAL PRIMARY KEY,
	"name" VARCHAR(20) NOT NULL UNIQUE
);

CREATE TABLE "bankAccount"(
	"id" SERIAL PRIMARY KEY,
	"customerId" INTEGER NOT NULL,
	"accountNumber" INTEGER NOT NULL,
	"agency" INTEGER NOT NULL,
	"openDate" TIMESTAMP DEFAULT NOW() NOT NULL,
	"closeDate" TIMESTAMP DEFAULT NULL
);

CREATE TABLE "transactions"(
	"id" SERIAL PRIMARY KEY,
	"bankAccountId" INTEGER NOT NULL,
	"amount" INTEGER NOT NULL,
	"type" VARCHAR(30) NOT NULL,
	"time" TIMESTAMP DEFAULT NOW() NOT NULL,
	"description" VARCHAR(100), -- it can be left empty/null
	"canceled" BOOLEAN DEFAULT FALSE NOT NULL
);

CREATE TABLE "creditCards"(
	"id" SERIAL PRIMARY KEY,
	"bankAccountId" INTEGER NOT NULL,
	"name" VARCHAR(30) NOT NULL,
	"number" VARCHAR(16) UNIQUE NOT NULL,
	"securityCode" INTEGER NOT NULL,
	"expirationMonth" INTEGER NOT NULL, 
	"expirationYear" INTEGER NOT NULL,
	"password" TEXT NOT NULL,
	"limit" INTEGER NOT NULL
);

ALTER TABLE "customers" ADD CONSTRAINT "chk_cpf0" CHECK ("cpf" ~ '^[0-9]*$'); 
ALTER TABLE "customers" ADD CONSTRAINT "chk_cpf1" CHECK (LENGTH("cpf") = 11);
ALTER TABLE "customers" ADD CONSTRAINT "chk_email0" CHECK ("email" LIKE '%_@__%.__%');

ALTER TABLE "customerAddresses" ADD CONSTRAINT "c_a_fk0" FOREIGN KEY ("customerId") REFERENCES "customers"("id");
ALTER TABLE "customerAddresses" ADD CONSTRAINT "c_a_fk1" FOREIGN KEY ("cityId") REFERENCES "cities"("id");
ALTER TABLE "customerAddresses" ADD CONSTRAINT "chk_p_c0" CHECK ("postalCode" ~ '^[0-9]*$'); 
ALTER TABLE "customerAddresses" ADD CONSTRAINT "chk_p_c1" CHECK (LENGTH("postalCode") = 8);

ALTER TABLE "customerPhones" ADD CONSTRAINT "c_p_fk0" FOREIGN KEY ("customerId") REFERENCES "customers"("id");
ALTER TABLE "customerPhones" ADD CONSTRAINT "chk_number0" CHECK ("number" ~ '^[0-9]*$'); 
ALTER TABLE "customerPhones" ADD CONSTRAINT "chk_number1" CHECK (LENGTH("number") BETWEEN 10 AND 11);
ALTER TABLE "customerPhones" ADD CONSTRAINT "chk_type0" CHECK ("type" IN ('Landline', 'Mobile', 'Work'));

ALTER TABLE "cities" ADD CONSTRAINT "cities_fk0" FOREIGN KEY ("stateId") REFERENCES "states"("id");

ALTER TABLE "bankAccount" ADD CONSTRAINT "b_a_fk0" FOREIGN KEY ("customerId") REFERENCES "customers"("id");
ALTER TABLE "bankAccount" ADD CONSTRAINT "a_number0" CHECK ("accountNumber" ~ '^[0-9]*$');
ALTER TABLE "bankAccount" ADD CONSTRAINT "a_number1" CHECK (LENGTH("accountNumber") BETWEEN 4 AND 6);
ALTER TABLE "bankAccount" ADD CONSTRAINT "agency0" CHECK ("agency" ~ '^[0-9]*$');
ALTER TABLE "bankAccount" ADD CONSTRAINT "agency1" CHECK (LENGTH("agency") BETWEEN 3 AND 4);

ALTER TABLE "transactions" ADD CONSTRAINT "t_fk0" FOREIGN KEY ("bankAccountId") REFERENCES "bankAccount"("id");
ALTER TABLE "transactions" ADD CONSTRAINT "chk_type0" CHECK ("type" IN ('Withdraw', 'Deposit', 'Loan', 'Debit', 'Incoming', 'Outcoming', 'Salary'));

ALTER TABLE "creditCards" ADD CONSTRAINT "b_a_fk0" FOREIGN KEY ("bankAccountId") REFERENCES "bankAccount"("id");

ALTER TABLE "creditCards" ADD CONSTRAINT "chk_name0" CHECK ("name" ~ '^[A-Z\0-9]*$');
ALTER TABLE "creditCards" ADD CONSTRAINT "chk_number0" CHECK ("number" ~ '^[0-9]*$');
ALTER TABLE "creditCards" ADD CONSTRAINT "chk_number1" CHECK (LENGTH("number") = 16);
ALTER TABLE "creditCards" ADD CONSTRAINT "chk_securityCode0" CHECK ("securityCode" BETWEEN 001 AND 999);
ALTER TABLE "creditCards" ADD CONSTRAINT "chk_expirationMonth0" CHECK ("expirationMonth" BETWEEN 01 AND 12);;
ALTER TABLE "creditCards" ADD CONSTRAINT "chk_expirationYear0" CHECK ("expirationYear" >= DATE_PART ('year', CURRENT_DATE) );
ALTER TABLE "creditCards" ADD CONSTRAINT "chk_limit0" CHECK ("limit" >= 0);
CREATE DATABASE "course";

CREATE TABLE "students"(
	"id" SERIAL PRIMARY KEY,
	"name" TEXT NOT NULL,
	"cpf" VARCHAR(11) UNIQUE NOT NULL,
	"email" TEXT UNIQUE NOT NULL
);

CREATE TABLE "classes"(
	"id" SERIAL PRIMARY KEY,
	"code" VARCHAR(3) UNIQUE NOT NULL
);

CREATE TABLE "classes_students"(
	"id" SERIAL PRIMARY KEY,
	"student_id" INTEGER NOT NULL,
	"class_id" INTEGER NOT NULL,
	"start_date" TIMESTAMP DEFAULT NOW() NOT NULL,
	"end_date" TIMESTAMP DEFAULT(NULL)
);

CREATE TABLE "modules"(
	"id" SERIAL PRIMARY KEY,
	"name" TEXT UNIQUE NOT NULL
);

CREATE TABLE "projects"(
	"id" SERIAL PRIMARY KEY,
	"name" TEXT UNIQUE NOT NULL,
	"module_id" INTEGER NOT NULL
);

CREATE TABLE "projects_students"(
	"id" SERIAL PRIMARY KEY,
	"student_id" INTEGER NOT NULL,
	"project_id" INTEGER NOT NULL,
	"grade" TEXT NOT NULL
);	

-- ALTER TABLE "students" ADD CONSTRAINT "chk_cpf0" CHECK (LENGTH("cpf") = 11);
-- ALTER TABLE "students" ADD CONSTRAINT "chk_cpf1" CHECK ("cpf" ~ '^[0-9]*$');
-- ALTER TABLE "students" ADD CONSTRAINT "chk_email0" CHECK ("email" LIKE '%_@__%.__%');

-- ALTER TABLE "classes" ADD CONSTRAINT "chk_code0" CHECK("code" ~ '^[A-Z\0-9]*$');

ALTER TABLE "classes_students" ADD CONSTRAINT "s_fk0" FOREIGN KEY ("student_id") REFERENCES "students"("id");
ALTER TABLE "classes_students" ADD CONSTRAINT "c_fk0" FOREIGN KEY ("class_id") REFERENCES "classes"("id");

ALTER TABLE "projects" ADD CONSTRAINT "m_fk0" FOREIGN KEY ("module_id") REFERENCES "modules"("id");

ALTER TABLE "projects_students" ADD CONSTRAINT "s_fk0" FOREIGN KEY ("student_id") REFERENCES "students"("id");
ALTER TABLE "projects_students" ADD CONSTRAINT "p_fk0" FOREIGN KEY ("project_id") REFERENCES "projects"("id");
-- ALTER TABLE "projects_students" ADD CONSTRAINT "chk_grade0" CHECK ("grade" IN ('Acima das expectativas', 'Dentro das expectativas', 'Abaixo das expectativas'));
CREATE TABLE addresses(
	"id" SERIAL PRIMARY KEY,
	"street" VARCHAR(50) NOT NULL,
	"cep" VARCHAR(10) NOT NULL,
	"number" VARCHAR(10) NOT NULL,
	"additionalInfo" VARCHAR(50) DEFAULT(NULL),
	"city" VARCHAR(50) NOT NULL,
	"state" VARCHAR(2) NOT NULL,
	"userId" INTEGER NOT NULL REFERENCES "users"("id"),
	CONSTRAINT "chk_state" CHECK (state IN ('AC', 'AM', 'RO', 'RR', 'PA', 'TO', 'AP', 'MA', 'PI', 'CE', 'RN', 'PB', 'PE', 'AL', 'SE', 'BA', 'ES', 'RJ', 'SP', 'MG', 'MS', 'GO', 'MT', 'DF', 'RS', 'SC', 'PR')),
	CONSTRAINT "chk_cep" CHECK (LENGTH(cep) BETWEEN 9 AND 10)
);
CREATE TABLE purchases(
	"id" SERIAL PRIMARY KEY,
	"userId" INTEGER NOT NULL REFERENCES "users"("id"),
	"productId" INTEGER NOT NULL REFERENCES "products"("id"),
	"status" VARCHAR(20) NOT NULL,
	"addressId" INTEGER NOT NULL REFERENCES "addresses"("id"),
	"createdAt" TIMESTAMP DEFAULT NOW() NOT NULL,
	CONSTRAINT "chk_status" CHECK (status IN('criada', 'paga', 'entregue', 'cancelada'))
);


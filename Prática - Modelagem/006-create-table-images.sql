CREATE TABLE images(
	"id" SERIAL PRIMARY KEY,
	"url" TEXT UNIQUE NOT NULL,
	"productId" INTEGER NOT NULL REFERENCES "products"("id"),
	"mainImage" BOOLEAN NOT NULL DEFAULT (false)
);
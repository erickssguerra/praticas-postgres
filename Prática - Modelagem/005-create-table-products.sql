CREATE TABLE products(
	"id" SERIAL PRIMARY KEY,
	"name" VARCHAR(50) NOT NULL,
	"price" INTEGER NOT NULL,
	"categoryId" INTEGER NOT NULL REFERENCES "categories"("id"),
	"size" VARCHAR(20) NOT NULL,
	"stock" INTEGER NOT NULL DEFAULT(1),
	CONSTRAINT "chk_price" CHECK (price>0),
	CONSTRAINT "chk_size" CHECK (size IN ('PPP', 'PP', 'P', 'M', 'G', 'GG', 'GGG', 'Sob encomenda')),
	CONSTRAINT "chk_stock" CHECK (stock>0)
);
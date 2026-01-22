-- CreateTable
CREATE TABLE "User" (
    "id" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "notification_token" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "User_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Retailer" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "domain" TEXT NOT NULL,

    CONSTRAINT "Retailer_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Category" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "current_index_score" DECIMAL(65,30),

    CONSTRAINT "Category_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Product" (
    "id" TEXT NOT NULL,
    "category_id" TEXT NOT NULL,
    "group_id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "brand" TEXT,
    "is_kvi" BOOLEAN NOT NULL DEFAULT false,
    "rolling_avg_unit_price" DECIMAL(65,30),

    CONSTRAINT "Product_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "UserInterest" (
    "id" TEXT NOT NULL,
    "user_id" TEXT NOT NULL,
    "product_id" TEXT NOT NULL,
    "interest_score" DECIMAL(65,30) NOT NULL DEFAULT 0,
    "is_watchlisted" BOOLEAN NOT NULL DEFAULT false,
    "last_interaction" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "UserInterest_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PriceRecord" (
    "id" TEXT NOT NULL,
    "product_id" TEXT NOT NULL,
    "retailer_id" TEXT NOT NULL,
    "price" DECIMAL(65,30) NOT NULL,
    "unit_price" DECIMAL(65,30) NOT NULL,
    "is_deal" BOOLEAN NOT NULL DEFAULT false,
    "price_delta_percent" DECIMAL(65,30),
    "timestamp" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "PriceRecord_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");

-- CreateIndex
CREATE UNIQUE INDEX "Retailer_domain_key" ON "Retailer"("domain");

-- CreateIndex
CREATE UNIQUE INDEX "Category_name_key" ON "Category"("name");

-- CreateIndex
CREATE INDEX "UserInterest_user_id_idx" ON "UserInterest"("user_id");

-- CreateIndex
CREATE INDEX "UserInterest_product_id_idx" ON "UserInterest"("product_id");

-- CreateIndex
CREATE UNIQUE INDEX "UserInterest_user_id_product_id_key" ON "UserInterest"("user_id", "product_id");

-- CreateIndex
CREATE INDEX "PriceRecord_product_id_idx" ON "PriceRecord"("product_id");

-- CreateIndex
CREATE INDEX "PriceRecord_retailer_id_idx" ON "PriceRecord"("retailer_id");

-- CreateIndex
CREATE INDEX "PriceRecord_timestamp_idx" ON "PriceRecord"("timestamp");

-- CreateIndex
CREATE INDEX "PriceRecord_is_deal_idx" ON "PriceRecord"("is_deal");

-- AddForeignKey
ALTER TABLE "Product" ADD CONSTRAINT "Product_category_id_fkey" FOREIGN KEY ("category_id") REFERENCES "Category"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UserInterest" ADD CONSTRAINT "UserInterest_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UserInterest" ADD CONSTRAINT "UserInterest_product_id_fkey" FOREIGN KEY ("product_id") REFERENCES "Product"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PriceRecord" ADD CONSTRAINT "PriceRecord_product_id_fkey" FOREIGN KEY ("product_id") REFERENCES "Product"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PriceRecord" ADD CONSTRAINT "PriceRecord_retailer_id_fkey" FOREIGN KEY ("retailer_id") REFERENCES "Retailer"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

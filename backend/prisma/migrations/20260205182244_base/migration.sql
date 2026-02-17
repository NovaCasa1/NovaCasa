-- CreateTable
CREATE TABLE "User" (
    "id" BIGSERIAL NOT NULL,
    "password" VARCHAR(255) NOT NULL,
    "email" TEXT NOT NULL,
    "photoUrl" TEXT,
    "telephone" VARCHAR(20) NOT NULL,
    "dni" TEXT,
    "birthdate" TIMESTAMP(3) NOT NULL,
    "name" TEXT NOT NULL,
    "surname" TEXT NOT NULL,
    "countryId" BIGINT NOT NULL,
    "eu" BOOLEAN NOT NULL,

    CONSTRAINT "User_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "FavSearchDwelling" (
    "id" BIGSERIAL NOT NULL,
    "direction" TEXT NOT NULL,
    "cityId" BIGINT NOT NULL,
    "type" TEXT NOT NULL,
    "rooms" INTEGER NOT NULL,
    "squareMeters" DOUBLE PRECISION NOT NULL,
    "price" DOUBLE PRECISION NOT NULL,
    "bathrooms" INTEGER NOT NULL,
    "userId" BIGINT NOT NULL,

    CONSTRAINT "FavSearchDwelling_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "FavSearchJob" (
    "id" BIGSERIAL NOT NULL,
    "cityId" BIGINT NOT NULL,
    "workSector" TEXT NOT NULL,
    "experience" TEXT NOT NULL,
    "workday" TEXT NOT NULL,
    "salary" DOUBLE PRECISION NOT NULL,
    "contract" TEXT NOT NULL,
    "userId" BIGINT NOT NULL,

    CONSTRAINT "FavSearchJob_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "FavSearchCity" (
    "id" BIGSERIAL NOT NULL,
    "countryId" BIGINT NOT NULL,
    "userId" BIGINT NOT NULL,

    CONSTRAINT "FavSearchCity_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "FavJob" (
    "id" BIGSERIAL NOT NULL,
    "userId" BIGINT NOT NULL,
    "jobId" BIGINT NOT NULL,

    CONSTRAINT "FavJob_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "FavCountry" (
    "id" BIGSERIAL NOT NULL,
    "userId" BIGINT NOT NULL,
    "countryId" BIGINT NOT NULL,

    CONSTRAINT "FavCountry_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "FavDwelling" (
    "id" BIGSERIAL NOT NULL,
    "userId" BIGINT NOT NULL,
    "dwellingId" BIGINT NOT NULL,

    CONSTRAINT "FavDwelling_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Procedure" (
    "id" BIGSERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "lastUpdate" TIMESTAMP(3) NOT NULL,
    "countryId" BIGINT NOT NULL,

    CONSTRAINT "Procedure_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Document" (
    "id" BIGSERIAL NOT NULL,
    "type" TEXT NOT NULL,
    "procedureId" BIGINT NOT NULL,

    CONSTRAINT "Document_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Country" (
    "id" BIGSERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "code" TEXT NOT NULL,
    "continent" TEXT NOT NULL,
    "flagUrl" TEXT,

    CONSTRAINT "Country_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "City" (
    "id" BIGSERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "code" TEXT NOT NULL,
    "countryId" BIGINT NOT NULL,

    CONSTRAINT "City_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "LivingCost" (
    "countryId" BIGINT NOT NULL,
    "foodCost" DOUBLE PRECISION NOT NULL,
    "transportCost" DOUBLE PRECISION NOT NULL,
    "monthlyEstimate" DOUBLE PRECISION NOT NULL,

    CONSTRAINT "LivingCost_pkey" PRIMARY KEY ("countryId")
);

-- CreateTable
CREATE TABLE "JobOffer" (
    "id" BIGSERIAL NOT NULL,
    "title" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "companyId" BIGINT NOT NULL,
    "countryId" BIGINT NOT NULL,
    "cityId" BIGINT NOT NULL,
    "contract" TEXT NOT NULL,
    "timestampStart" TIMESTAMP(3) NOT NULL,
    "timestampEnd" TIMESTAMP(3) NOT NULL,
    "requirements" TEXT NOT NULL,
    "workSector" TEXT NOT NULL,
    "workday" TEXT NOT NULL,
    "salary" DOUBLE PRECISION NOT NULL,

    CONSTRAINT "JobOffer_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Company" (
    "id" BIGSERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "cityId" BIGINT NOT NULL,

    CONSTRAINT "Company_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Dwelling" (
    "id" BIGSERIAL NOT NULL,
    "direction" TEXT NOT NULL,
    "cityId" BIGINT NOT NULL,
    "zipCode" TEXT NOT NULL,
    "type" TEXT NOT NULL,
    "rooms" INTEGER NOT NULL,
    "meters" DOUBLE PRECISION NOT NULL,
    "ownerId" BIGINT NOT NULL,
    "price" DOUBLE PRECISION NOT NULL,

    CONSTRAINT "Dwelling_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Owner" (
    "id" BIGSERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "telephone" TEXT NOT NULL,

    CONSTRAINT "Owner_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");

-- CreateIndex
CREATE UNIQUE INDEX "User_dni_key" ON "User"("dni");

-- CreateIndex
CREATE UNIQUE INDEX "Country_name_key" ON "Country"("name");

-- CreateIndex
CREATE UNIQUE INDEX "Country_code_key" ON "Country"("code");

-- CreateIndex
CREATE UNIQUE INDEX "Owner_email_key" ON "Owner"("email");

-- AddForeignKey
ALTER TABLE "User" ADD CONSTRAINT "User_countryId_fkey" FOREIGN KEY ("countryId") REFERENCES "Country"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "FavSearchDwelling" ADD CONSTRAINT "FavSearchDwelling_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "FavSearchJob" ADD CONSTRAINT "FavSearchJob_cityId_fkey" FOREIGN KEY ("cityId") REFERENCES "City"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "FavSearchJob" ADD CONSTRAINT "FavSearchJob_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "FavSearchCity" ADD CONSTRAINT "FavSearchCity_countryId_fkey" FOREIGN KEY ("countryId") REFERENCES "Country"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "FavSearchCity" ADD CONSTRAINT "FavSearchCity_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "FavJob" ADD CONSTRAINT "FavJob_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "FavJob" ADD CONSTRAINT "FavJob_jobId_fkey" FOREIGN KEY ("jobId") REFERENCES "JobOffer"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "FavCountry" ADD CONSTRAINT "FavCountry_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "FavCountry" ADD CONSTRAINT "FavCountry_countryId_fkey" FOREIGN KEY ("countryId") REFERENCES "Country"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "FavDwelling" ADD CONSTRAINT "FavDwelling_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "FavDwelling" ADD CONSTRAINT "FavDwelling_dwellingId_fkey" FOREIGN KEY ("dwellingId") REFERENCES "Dwelling"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Procedure" ADD CONSTRAINT "Procedure_countryId_fkey" FOREIGN KEY ("countryId") REFERENCES "Country"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Document" ADD CONSTRAINT "Document_procedureId_fkey" FOREIGN KEY ("procedureId") REFERENCES "Procedure"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "City" ADD CONSTRAINT "City_countryId_fkey" FOREIGN KEY ("countryId") REFERENCES "Country"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "LivingCost" ADD CONSTRAINT "LivingCost_countryId_fkey" FOREIGN KEY ("countryId") REFERENCES "Country"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "JobOffer" ADD CONSTRAINT "JobOffer_companyId_fkey" FOREIGN KEY ("companyId") REFERENCES "Company"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "JobOffer" ADD CONSTRAINT "JobOffer_countryId_fkey" FOREIGN KEY ("countryId") REFERENCES "Country"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "JobOffer" ADD CONSTRAINT "JobOffer_cityId_fkey" FOREIGN KEY ("cityId") REFERENCES "City"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Company" ADD CONSTRAINT "Company_cityId_fkey" FOREIGN KEY ("cityId") REFERENCES "City"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Dwelling" ADD CONSTRAINT "Dwelling_cityId_fkey" FOREIGN KEY ("cityId") REFERENCES "City"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Dwelling" ADD CONSTRAINT "Dwelling_ownerId_fkey" FOREIGN KEY ("ownerId") REFERENCES "Owner"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

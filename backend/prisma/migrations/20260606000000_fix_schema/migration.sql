-- Fix JobOffer: añadir columna experience, hacer opcionales cityId, timestampEnd, requirements, salary
ALTER TABLE "JobOffer" ADD COLUMN IF NOT EXISTS "experience" TEXT NOT NULL DEFAULT 'Not specified';
ALTER TABLE "JobOffer" ALTER COLUMN "cityId" DROP NOT NULL;
ALTER TABLE "JobOffer" ALTER COLUMN "timestampEnd" DROP NOT NULL;
ALTER TABLE "JobOffer" ALTER COLUMN "requirements" DROP NOT NULL;
ALTER TABLE "JobOffer" ALTER COLUMN "salary" DROP NOT NULL;

-- Fix Dwelling: añadir columna description, hacer opcional cityId
ALTER TABLE "Dwelling" ADD COLUMN IF NOT EXISTS "description" VARCHAR(255) NOT NULL DEFAULT '';
ALTER TABLE "Dwelling" ALTER COLUMN "cityId" DROP NOT NULL;

-- Fix Owner: hacer telephone opcional
ALTER TABLE "Owner" ALTER COLUMN "telephone" DROP NOT NULL;

-- Fix Company: hacer cityId opcional
ALTER TABLE "Company" ALTER COLUMN "cityId" DROP NOT NULL;

-- Fix Country: cambiar id a SERIAL (INTEGER)
-- (ya es compatible, no se toca)

-- Fix FavSearchDwelling: hacer columnas opcionales
ALTER TABLE "FavSearchDwelling" ALTER COLUMN "cityId" DROP NOT NULL;
ALTER TABLE "FavSearchDwelling" ALTER COLUMN "type" DROP NOT NULL;
ALTER TABLE "FavSearchDwelling" ALTER COLUMN "rooms" DROP NOT NULL;
ALTER TABLE "FavSearchDwelling" ALTER COLUMN "squareMeters" DROP NOT NULL;
ALTER TABLE "FavSearchDwelling" ALTER COLUMN "price" DROP NOT NULL;
ALTER TABLE "FavSearchDwelling" ALTER COLUMN "bathrooms" DROP NOT NULL;

-- Fix FavSearchJob: hacer columnas opcionales
ALTER TABLE "FavSearchJob" ALTER COLUMN "cityId" DROP NOT NULL;
ALTER TABLE "FavSearchJob" ALTER COLUMN "workSector" DROP NOT NULL;
ALTER TABLE "FavSearchJob" ALTER COLUMN "experience" DROP NOT NULL;
ALTER TABLE "FavSearchJob" ALTER COLUMN "workday" DROP NOT NULL;
ALTER TABLE "FavSearchJob" ALTER COLUMN "salary" DROP NOT NULL;

-- Fix LivingCost: añadir columna id
ALTER TABLE "LivingCost" ADD COLUMN IF NOT EXISTS "id" SERIAL;

-- Fix Procedure: hacer lastUpdate opcional
ALTER TABLE "Procedure" ALTER COLUMN "lastUpdate" DROP NOT NULL;
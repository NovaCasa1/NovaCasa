import { defineConfig } from "prisma/config";
import { Pool } from "pg";
import { PrismaPg } from "@prisma/adapter-pg";

const pool = new Pool({
  host: "127.0.0.1",
  port: 5432,
  user: "casanova",
  password: "estocolmo_rubias",
  database: "novacasadb",
});

const adapter = new PrismaPg(pool);

export default defineConfig({
  schema: "prisma/schema.prisma",
  migrations: {
    path: "prisma/migrations",
  },
  datasource: {
    url: "postgresql://casanova:estocolmo_rubias@127.0.0.1:5432/novacasadb",
  },
  adapter,
});
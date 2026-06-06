FROM node:20-alpine

RUN apk add --no-cache openssl

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY prisma ./prisma
RUN npx prisma generate

COPY src ./src

EXPOSE 3000

CMD ["sh", "-c", "rm -rf node_modules/@prisma/client && npx prisma generate && npx prisma migrate reset --force && node src/index.js"]
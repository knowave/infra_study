FROM node:18.17.0 AS builder

WORKDIR "/app"

# COPY . .
COPY package*.json ./
COPY tsconfig.build.json ./
COPY tsconfig.json ./

RUN npm install

COPY . .

# RUN npm ci
RUN npm run build
RUN npm prune --production

FROM node:18.17.0 AS production

WORKDIR "/app"

COPY --from=builder /app/package.json ./package.json
COPY --from=builder /app/package-lock.json ./package-lock.json
COPY --from=builder /app/migration_data.json ./migration_data.json
COPY --from=builder /app/dist ./dist
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/test-248516-firebase-adminsdk-iartf-f3b5aeb1ff.json ./test-248516-firebase-adminsdk-iartf-f3b5aeb1ff.json

CMD [ "sh", "-c", "npm run start:prod"]
FROM node:lts-alpine AS build
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build -- --mode custom

FROM node:lts-alpine AS runtime
COPY --from=build /dist .
FROM node:lts-alpine AS build
LABEL name=biati
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build -- --mode custom

FROM node:alpine AS runtime
LABEL name=biati
COPY --from=build /dist .
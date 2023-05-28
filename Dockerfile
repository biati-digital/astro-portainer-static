FROM node:lts AS build
WORKDIR /
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build -- --mode custom

FROM joseluisq/static-web-server AS runtime
COPY --from=build /dist /public_html
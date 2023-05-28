FROM node:lts AS build
WORKDIR /
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build -- --mode custom

#FROM joseluisq/static-web-server AS runtime
#COPY --from=build /dist /public_html
FROM nginx:alpine AS runtime
COPY ./nginx.conf /etc/nginx/nginx.conf
COPY --from=build /dist /usr/share/nginx/html
RUN chown -R www-data:www-data /usr/share/nginx/html
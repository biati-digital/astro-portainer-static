FROM node:lts-alpine AS build
WORKDIR /app

COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build -- --mode custom

FROM nginx:alpine AS runtime
COPY ./nginx.conf /etc/nginx/nginx.conf
COPY --from=build /app/dist /usr/share/nginx/html

WORKDIR /app
RUN chown -R www-data:www-data /app && chmod -R 755 /app && \
    chown -R www-data:www-data /var/cache/nginx && \
    chown -R www-data:www-data /var/log/nginx && \
    chown -R www-data:www-data /usr/share/nginx/html && \
    chown -R www-data:www-data /etc/nginx/conf.d
RUN touch /var/run/nginx.pid && \
    chown -R www-data:www-data /var/run/nginx.pid
USER nginx
#EXPOSE <PORT_NUMBER>
CMD ["nginx", "-g", "daemon off;"]
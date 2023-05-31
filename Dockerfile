FROM node:lts-alpine AS build
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build -- --mode custom

FROM nginx:alpine AS runtime
VOLUME /website
COPY ./nginx.conf /etc/nginx/nginx.conf
COPY --from=build /dist /usr/share/nginx/html
RUN chown nginx:nginx /usr/share/nginx/html/*
#COPY --from=build ./docker-entrypoint.sh /docker-entrypoint.sh
#RUN chmod +x /docker-entrypoint.sh
#ENTRYPOINT ["/docker-entrypoint.sh"]
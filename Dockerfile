FROM node:lts AS build
WORKDIR /
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build -- --mode custom

FROM joseluisq/static-web-server AS runtime
#COPY ./nginx/nginx.conf /etc/nginx/nginx.conf
#COPY --from=build /dist /usr/share/nginx/html
COPY --from=build /dist /public_html
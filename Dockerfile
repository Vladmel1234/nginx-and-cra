FROM node:latest
WORKDIR /usr/src/app
COPY package.json ./
RUN npm install
COPY . ./
RUN npm run build
RUN find /usr/src/app/build
# Stage 2 - the production environment
FROM nginx:latest
RUN rm /etc/nginx/conf.d/default.conf
COPY ./nginx.conf /etc/nginx/conf.d/
COPY --from=0 /usr/src/app/build /nginx/www
RUN find /nginx/www/
VOLUME /nginx
# CMD ["nginx", "-g", "daemon off;"]
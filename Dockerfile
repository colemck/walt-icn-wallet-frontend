FROM node:16 as buildstage
COPY ./package.json /package.json
RUN yarn install
COPY . /
RUN yarn generate
FROM nginx:latest
COPY nginx.conf /etc/nginx/nginx.conf
COPY --chown=nginx --from=buildstage /dist/ /usr/share/nginx/html/
RUN find /usr/share/nginx/html -type d -exec chmod 755 {} +

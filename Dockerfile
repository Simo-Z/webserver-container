FROM node:18 AS build
WORKDIR /app
COPY src/ .
RUN npm install -g html-minifier && \
    html-minifier --collapse-whitespace --remove-comments --remove-optional-tags -o index.html index.html

FROM nginx:latest
WORKDIR /usr/share/nginx/html
COPY --from=build /app/ .

EXPOSE 80
CMD ["nginx", "-g"]

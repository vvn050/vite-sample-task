FROM node:18-alpine as build-client
WORKDIR /app
COPY ./package.json .
COPY ./yarn.lock .
RUN yarn install
COPY . .
RUN yarn build
FROM node:18-alpine as build-server
COPY /server /app/server
COPY --from=build-client /app/server/dist /app/server/dist
WORKDIR /app/server
RUN yarn install
CMD ["node", "index"]
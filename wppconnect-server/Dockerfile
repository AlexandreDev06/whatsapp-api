FROM node:16.19-alpine3.17 as builder

RUN apk add wget && \
    apk add --no-cache git

WORKDIR /home/node
RUN git clone https://github.com/wppconnect-team/wppconnect-server.git /home/node/app

WORKDIR /home/node/app
COPY ./config.json /home/node/app/src
RUN yarn install

FROM node:16.19-alpine3.17
WORKDIR /home/node/app
RUN apk add chromium
COPY --from=builder /home/node/app/ .
EXPOSE 21465

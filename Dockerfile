# Use the latest foundry image
FROM debian:bullseye as builder

ENV PATH=/usr/local/node/bin:$PATH
ARG NODE_VERSION=16.13.0

RUN apt-get update; apt install -y curl python-is-python3 pkg-config build-essential && \
    curl -sL https://github.com/nodenv/node-build/archive/master.tar.gz | tar xz -C /tmp/ && \
    /tmp/node-build-master/bin/node-build "${NODE_VERSION}" /usr/local/node && \
rm -rf /tmp/node-build-master

RUN mkdir /app
WORKDIR /app

COPY . .

RUN npm install

RUN apt-get install libstdc++6

FROM ghcr.io/foundry-rs/foundry:latest

LABEL fly_launch_runtime="nodejs"

COPY --from=builder /usr/local/node /usr/local/node
COPY --from=builder /app /app
# COPY --from=foundry /usr/local/bin/forge /usr/local/bin/forge

WORKDIR /app
ENV NODE_ENV production
ENV PATH /usr/local/node/bin:$PATH

CMD [ "npm", "run", "start" ]

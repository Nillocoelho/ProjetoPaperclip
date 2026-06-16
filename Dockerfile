FROM node:22-bookworm-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
    socat \
    git \
    bash \
    python3 \
    make \
    g++ \
    ripgrep \
    postgresql-client \
    ca-certificates \
    curl \
    wget \
    && rm -rf /var/lib/apt/lists/*

RUN npm install -g paperclipai @openai/codex \
    && chown -R node:node /usr/local/lib/node_modules /usr/local/bin

RUN mkdir -p /workspace /home/node/paperclip \
    && chown -R node:node /workspace /home/node/paperclip

COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

RUN chmod +x /usr/local/bin/docker-entrypoint.sh \
    && chown node:node /usr/local/bin/docker-entrypoint.sh

USER node

WORKDIR /home/node/paperclip

ENV PAPERCLIP_HOME=/home/node/paperclip
ENV PAPERCLIP_DATA_DIR=/home/node/paperclip
ENV PAPERCLIP_WORKSPACE_DIR=/workspace
ENV PORT=3100

EXPOSE 3100
EXPOSE 3101

CMD ["docker-entrypoint.sh"]
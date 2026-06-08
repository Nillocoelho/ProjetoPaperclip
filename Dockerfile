FROM node:22-alpine

RUN apk add --no-cache socat git bash python3 make g++ ripgrep
RUN npm install -g paperclipai @openai/codex

USER node
WORKDIR /home/node/paperclip

ENV PAPERCLIP_HOME=/home/node/paperclip
ENV PAPERCLIP_DATA_DIR=/home/node/paperclip
ENV PAPERCLIP_WORKSPACE_DIR=/workspace
ENV PORT=3100

EXPOSE 3100
EXPOSE 3101

CMD sh -c "socat TCP-LISTEN:3101,fork,reuseaddr TCP:127.0.0.1:3100 & paperclipai onboard --yes --run"

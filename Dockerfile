FROM alpine:3.18.2 as base

FROM base as download

ARG FILEBROWSER_VERSION

WORKDIR /dl

RUN apk add --no-cache wget

RUN wget -nv https://github.com/filebrowser/filebrowser/releases/download/v${FILEBROWSER_VERSION}/linux-amd64-filebrowser.tar.gz

RUN tar -xzf linux-amd64-filebrowser.tar.gz

FROM base as runner

WORKDIR /app

COPY --from=download dl/filebrowser ./

COPY start.sh ./

RUN chmod +x filebrowser && chmod +x start.sh

CMD ["sh", "start.sh"]
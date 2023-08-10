FROM alpine:3.18.3 as base

FROM base as download

ARG FILEBROWSER_VERSION=2.24.2

WORKDIR /download

RUN apk add --no-cache wget

RUN wget -nv https://github.com/filebrowser/filebrowser/releases/download/v${FILEBROWSER_VERSION}/linux-amd64-filebrowser.tar.gz \
    && tar -zxvf linux-amd64-filebrowser.tar.gz filebrowser \
    && chmod +x filebrowser

FROM base as runner

WORKDIR /app

COPY --from=download /download/filebrowser /usr/bin/

COPY start.sh ./

RUN chmod +x start.sh

CMD ["sh", "start.sh"]
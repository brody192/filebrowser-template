# FROM alpine:3.18.3 as base

# FROM base as download

# WORKDIR /download

# RUN apk add --no-cache wget

# ARG FILEBROWSER_VERSION=2.24.2

# RUN wget -nv https://github.com/filebrowser/filebrowser/releases/download/v${FILEBROWSER_VERSION}/linux-amd64-filebrowser.tar.gz \
#     && tar -zxvf linux-amd64-filebrowser.tar.gz filebrowser \
#     && chmod +x filebrowser

# FROM base as runner

# WORKDIR /app

# COPY --from=download /download/filebrowser /usr/bin/

FROM filebrowser/filebrowser:v2.24.2

COPY --chmod=755 start.sh ./

ENTRYPOINT ["start.sh"]

# CMD ["sh", "start.sh"]
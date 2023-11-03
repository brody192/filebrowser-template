FROM alpine:3.18.3

COPY --from=filebrowser/filebrowser:latest filebrowser /usr/bin/

COPY --chmod=755 start.sh ./

ENTRYPOINT ["/bin/sh"]

CMD ["start.sh"]
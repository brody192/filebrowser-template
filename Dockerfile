FROM alpine:3.18.3

COPY --from=filebrowser/filebrowser:v2.24.2 filebrowser /usr/bin/

COPY --chmod=755 start.sh ./

ENTRYPOINT ["/bin/sh"]

CMD ["start.sh"]
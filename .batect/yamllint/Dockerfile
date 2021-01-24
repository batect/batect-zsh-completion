FROM alpine:3.13.0@sha256:d0710affa17fad5f466a70159cc458227bd25d4afb39514ef662ead3e6c99515

RUN apk add --no-cache yamllint=1.23.0-r0

COPY bundle-default.yml /root/.config/yamllint/config

FROM alpine:3.13.0@sha256:d0710affa17fad5f466a70159cc458227bd25d4afb39514ef662ead3e6c99515

RUN apk --no-cache add \
    bash==5.0.17-r0 \
    zsh==5.8-r1 \
    python3==3.8.5-r0

COPY zshrc /root/.zshrc
COPY complete.zsh /usr/local/bin/complete.zsh

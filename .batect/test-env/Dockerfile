FROM alpine:3.13.2@sha256:a75afd8b57e7f34e4dad8d65e2c7ba2e1975c795ce1ee22fa34f8cf46f96a3be

RUN apk --no-cache add \
    bash==5.1.0-r0 \
    zsh==5.8-r1 \
    python3==3.8.7-r1

COPY zshrc /root/.zshrc
COPY complete.zsh /usr/local/bin/complete.zsh

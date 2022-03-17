FROM alpine:3.15.1@sha256:d6d0a0eb4d40ef96f2310ead734848b9c819bb97c9d846385c4aca1767186cd4

RUN apk --no-cache add \
    bash==5.1.16-r0 \
    zsh==5.8.1-r0 \
    python3==3.9.7-r4 \
    util-linux==2.37.4-r0 # For uuidgen

COPY zshrc /root/.zshrc
COPY complete.zsh /usr/local/bin/complete.zsh

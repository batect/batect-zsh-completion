FROM alpine:3.14.0@sha256:234cb88d3020898631af0ccbbcca9a66ae7306ecd30c9720690858c1b007d2a0

RUN apk --no-cache add \
    bash==5.1.0-r0 \
    zsh==5.8-r2 \
    python3==3.9.5-r0 \
    util-linux==2.37-r0 # For uuidgen

COPY zshrc /root/.zshrc
COPY complete.zsh /usr/local/bin/complete.zsh

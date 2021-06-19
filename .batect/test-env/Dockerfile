FROM alpine:3.14.0@sha256:234cb88d3020898631af0ccbbcca9a66ae7306ecd30c9720690858c1b007d2a0

RUN apk --no-cache add \
    zsh==5.8-r2 \
    bash==5.1.4-r0 \
    python3==3.8.10-r0 \
    util-linux==2.36.1-r1 # For uuidgen

COPY zshrc /root/.zshrc
COPY complete.zsh /usr/local/bin/complete.zsh

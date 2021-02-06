FROM alpine:3.13.1@sha256:08d6ca16c60fe7490c03d10dc339d9fd8ea67c6466dea8d558526b1330a85930

RUN apk --no-cache add \
    bash==5.1.0-r0 \
    zsh==5.8-r1 \
    python3==3.8.7-r0

COPY zshrc /root/.zshrc
COPY complete.zsh /usr/local/bin/complete.zsh

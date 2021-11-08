FROM alpine:3.14.2@sha256:e1c082e3d3c45cccac829840a25941e679c25d438cc8412c2fa221cf1a824e6a

RUN apk --no-cache add \
    bash==5.1.4-r0 \
    zsh==5.8-r2 \
    python3==3.9.5-r1 \
    util-linux==2.37.2-r0 # For uuidgen

COPY zshrc /root/.zshrc
COPY complete.zsh /usr/local/bin/complete.zsh

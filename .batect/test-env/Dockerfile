FROM alpine:3.15.2@sha256:66b861b1099af1551a0eee163c175fd008744192c3fbb7f22e998db0ce09e8ea

RUN apk --no-cache add \
    bash==5.1.16-r0 \
    zsh==5.8.1-r0 \
    python3==3.9.7-r4 \
    util-linux==2.37.4-r0 # For uuidgen

COPY zshrc /root/.zshrc
COPY complete.zsh /usr/local/bin/complete.zsh

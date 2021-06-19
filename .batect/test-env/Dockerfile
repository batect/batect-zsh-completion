FROM alpine:3.13.5@sha256:69e70a79f2d41ab5d637de98c1e0b055206ba40a8145e7bddb55ccc04e13cf8f

RUN apk --no-cache add \
    bash==5.1.0-r0 \
    zsh==5.8-r1 \
    python3==3.8.10-r0 \
    util-linux==2.37-r0 # For uuidgen

COPY zshrc /root/.zshrc
COPY complete.zsh /usr/local/bin/complete.zsh

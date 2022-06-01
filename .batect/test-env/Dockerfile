FROM alpine:3.16.0@sha256:686d8c9dfa6f3ccfc8230bc3178d23f84eeaf7e457f36f271ab1acc53015037c

RUN apk --no-cache add \
    bash==5.1.16-r2 \
    zsh==5.8.1-r0 \
    python3==3.9.7-r4 \
    util-linux==2.37.4-r0 # For uuidgen

COPY zshrc /root/.zshrc
COPY complete.zsh /usr/local/bin/complete.zsh

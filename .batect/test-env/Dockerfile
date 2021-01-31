FROM alpine:3.13.0@sha256:d9a7354e3845ea8466bb00b22224d9116b183e594527fb5b6c3d30bc01a20378

RUN apk --no-cache add \
    bash==5.1.0-r0 \
    zsh==5.8-r1 \
    python3==3.8.7-r0

COPY zshrc /root/.zshrc
COPY complete.zsh /usr/local/bin/complete.zsh

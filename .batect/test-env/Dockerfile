FROM alpine:3.14.1@sha256:3afa84775f9bf065eb68694d88f1f455c80ac87063d7367b3678489e671bcad9

RUN apk --no-cache add \
    bash==5.1.4-r0 \
    zsh==5.8-r2 \
    python3==3.9.5-r1 \
    util-linux==2.37-r0 # For uuidgen

COPY zshrc /root/.zshrc
COPY complete.zsh /usr/local/bin/complete.zsh

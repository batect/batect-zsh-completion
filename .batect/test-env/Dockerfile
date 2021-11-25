FROM alpine:3.14.3@sha256:230cdd0ecad7d678b69b033748ac07183a26115ab1050a5d464105eafbe57859

RUN apk --no-cache add \
    bash==5.1.4-r0 \
    zsh==5.8-r2 \
    python3==3.9.5-r2 \
    util-linux==2.37.2-r0 # For uuidgen

COPY zshrc /root/.zshrc
COPY complete.zsh /usr/local/bin/complete.zsh

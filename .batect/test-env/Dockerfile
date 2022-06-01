FROM alpine:3.15.4@sha256:4edbd2beb5f78b1014028f4fbb99f3237d9561100b6881aabbf5acce2c4f9454

RUN apk --no-cache add \
    bash==5.1.16-r0 \
    zsh==5.8.1-r4 \
    python3==3.9.7-r4 \
    util-linux==2.37.4-r0 # For uuidgen

COPY zshrc /root/.zshrc
COPY complete.zsh /usr/local/bin/complete.zsh

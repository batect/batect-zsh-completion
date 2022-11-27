FROM alpine:3.17.0@sha256:8914eb54f968791faf6a8638949e480fef81e697984fba772b3976835194c6d4

RUN apk add --no-cache yamllint=1.26.3-r1

COPY bundle-default.yml /root/.config/yamllint/config

FROM alpine:3.13.1@sha256:08d6ca16c60fe7490c03d10dc339d9fd8ea67c6466dea8d558526b1330a85930

RUN apk add --no-cache yamllint=1.23.0-r0

COPY bundle-default.yml /root/.config/yamllint/config

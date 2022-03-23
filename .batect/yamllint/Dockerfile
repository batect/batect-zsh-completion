FROM alpine:3.15.2@sha256:66b861b1099af1551a0eee163c175fd008744192c3fbb7f22e998db0ce09e8ea

RUN apk add --no-cache yamllint=1.26.3-r0

COPY bundle-default.yml /root/.config/yamllint/config

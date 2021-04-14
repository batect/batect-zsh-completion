FROM alpine:3.13.5@sha256:69e70a79f2d41ab5d637de98c1e0b055206ba40a8145e7bddb55ccc04e13cf8f

RUN apk add --no-cache yamllint=1.23.0-r0

COPY bundle-default.yml /root/.config/yamllint/config

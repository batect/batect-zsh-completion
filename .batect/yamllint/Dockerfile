FROM alpine:3.16.2@sha256:bc41182d7ef5ffc53a40b044e725193bc10142a1243f395ee852a8d9730fc2ad

RUN apk add --no-cache yamllint=1.26.3-r1

COPY bundle-default.yml /root/.config/yamllint/config

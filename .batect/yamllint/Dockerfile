FROM alpine:3.15.3@sha256:f22945d45ee2eb4dd463ed5a431d9f04fcd80ca768bb1acf898d91ce51f7bf04

RUN apk add --no-cache yamllint=1.26.3-r0

COPY bundle-default.yml /root/.config/yamllint/config

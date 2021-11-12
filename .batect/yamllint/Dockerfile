FROM alpine:3.14.3@sha256:230cdd0ecad7d678b69b033748ac07183a26115ab1050a5d464105eafbe57859

RUN apk add --no-cache yamllint=1.26.1-r0

COPY bundle-default.yml /root/.config/yamllint/config

FROM alpine:3.16.0@sha256:686d8c9dfa6f3ccfc8230bc3178d23f84eeaf7e457f36f271ab1acc53015037c

RUN apk add --no-cache yamllint=1.26.3-r1

COPY bundle-default.yml /root/.config/yamllint/config

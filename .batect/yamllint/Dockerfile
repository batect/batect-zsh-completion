FROM alpine:3.14.1@sha256:3afa84775f9bf065eb68694d88f1f455c80ac87063d7367b3678489e671bcad9

RUN apk add --no-cache yamllint=1.26.1-r0

COPY bundle-default.yml /root/.config/yamllint/config

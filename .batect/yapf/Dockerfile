FROM alpine:3.18.2@sha256:82d1e9d7ed48a7523bdebc18cf6290bdb97b82302a8a9c27d4fe885949ea94d1

RUN apk add --no-cache py3-pip=23.1.2-r0 \
    && pip install --no-cache-dir yapf==0.33.0

COPY style.yapf /root/.config/yapf/style

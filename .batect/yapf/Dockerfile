FROM alpine:3.17.3@sha256:124c7d2707904eea7431fffe91522a01e5a861a624ee31d03372cc1d138a3126

RUN apk add --no-cache py3-pip=23.1.2-r0 \
    && pip install --no-cache-dir yapf==0.33.0

COPY style.yapf /root/.config/yapf/style

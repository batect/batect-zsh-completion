FROM alpine:3.15.2@sha256:66b861b1099af1551a0eee163c175fd008744192c3fbb7f22e998db0ce09e8ea

RUN apk add --no-cache py3-pip=20.3.4-r1 \
    && pip install --no-cache-dir yapf==0.32.0

COPY style.yapf /root/.config/yapf/style

FROM alpine:3.16.2@sha256:bc41182d7ef5ffc53a40b044e725193bc10142a1243f395ee852a8d9730fc2ad

RUN apk add --no-cache py3-pip=22.1.1-r0 \
    && pip install --no-cache-dir yapf==0.32.0

COPY style.yapf /root/.config/yapf/style

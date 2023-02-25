FROM alpine:3.17.2@sha256:69665d02cb32192e52e07644d76bc6f25abeb5410edc1c7a81a10ba3f0efb90a

RUN apk add --no-cache py3-pip=22.3.1-r1 \
    && pip install --no-cache-dir yapf==0.32.0

COPY style.yapf /root/.config/yapf/style

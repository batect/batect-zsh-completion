FROM alpine:3.13.2@sha256:a75afd8b57e7f34e4dad8d65e2c7ba2e1975c795ce1ee22fa34f8cf46f96a3be

RUN apk add --no-cache py3-pip=20.3.4-r0
RUN pip install --no-cache-dir yapf==0.30.0

COPY style.yapf /root/.config/yapf/style

FROM alpine:3.15.4@sha256:4edbd2beb5f78b1014028f4fbb99f3237d9561100b6881aabbf5acce2c4f9454

RUN apk add --no-cache py3-pip=20.3.4-r1 \
    && pip install --no-cache-dir yapf==0.32.0

COPY style.yapf /root/.config/yapf/style

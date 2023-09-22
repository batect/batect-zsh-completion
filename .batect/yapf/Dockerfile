FROM alpine:3.18.3@sha256:7144f7bab3d4c2648d7e59409f15ec52a18006a128c733fcff20d3a4a54ba44a

RUN apk add --no-cache py3-pip=23.1.2-r0 \
    && pip install --no-cache-dir yapf==0.40.2

COPY style.yapf /root/.config/yapf/style

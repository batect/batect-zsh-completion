FROM alpine:3.13.1@sha256:08d6ca16c60fe7490c03d10dc339d9fd8ea67c6466dea8d558526b1330a85930

RUN apk add --no-cache py3-pip=20.3.4-r0
RUN pip install yapf==0.30.0

COPY style.yapf /root/.config/yapf/style

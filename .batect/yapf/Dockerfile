FROM alpine:3.13.0@sha256:d9a7354e3845ea8466bb00b22224d9116b183e594527fb5b6c3d30bc01a20378

RUN apk add --no-cache py3-pip=20.3.4-r0
RUN pip install yapf==0.30.0

COPY style.yapf /root/.config/yapf/style

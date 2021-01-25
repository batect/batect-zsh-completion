FROM alpine:3.13.0@sha256:d0710affa17fad5f466a70159cc458227bd25d4afb39514ef662ead3e6c99515

RUN apk add --no-cache py3-pip=20.3.4-r0
RUN pip install yapf==0.30.0

COPY style.yapf /root/.config/yapf/style

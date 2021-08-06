FROM alpine:3.14.1@sha256:3afa84775f9bf065eb68694d88f1f455c80ac87063d7367b3678489e671bcad9

RUN apk add --no-cache py3-pip=20.3.4-r1 \
    && pip install --no-cache-dir yapf==0.30.0

COPY style.yapf /root/.config/yapf/style

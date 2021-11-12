FROM alpine:3.14.3@sha256:230cdd0ecad7d678b69b033748ac07183a26115ab1050a5d464105eafbe57859

RUN apk add --no-cache py3-pip=20.3.4-r1 \
    && pip install --no-cache-dir yapf==0.31.0

COPY style.yapf /root/.config/yapf/style

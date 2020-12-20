FROM alpine:3.12.3@sha256:074d3636ebda6dd446d0d00304c4454f468237fdacf08fb0eeac90bdbfa1bac7

RUN apk add --no-cache py3-pip=20.1.1-r0
RUN pip install yapf==0.30.0

COPY style.yapf /root/.config/yapf/style

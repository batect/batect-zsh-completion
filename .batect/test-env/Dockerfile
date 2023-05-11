FROM alpine:3.17.3@sha256:124c7d2707904eea7431fffe91522a01e5a861a624ee31d03372cc1d138a3126

RUN apk --no-cache add \
    bash==5.2.15-r0 \
    zsh==5.9-r0 \
    python3==3.10.11-r0 \
    py3-pip==23.1.2-r0 \
    util-linux==2.38.1-r1 # For uuidgen

COPY requirements.txt /tmp/requirements.txt
RUN pip3 install --no-cache-dir -r /tmp/requirements.txt && rm /tmp/requirements.txt

COPY .zshrc /root/.zshrc
COPY complete.py /usr/local/bin/complete.py

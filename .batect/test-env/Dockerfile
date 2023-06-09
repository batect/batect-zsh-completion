FROM alpine:3.18.0@sha256:02bb6f428431fbc2809c5d1b41eab5a68350194fb508869a33cb1af4444c9b11

RUN apk --no-cache add \
    bash==5.2.15-r5 \
    zsh==5.9-r2 \
    python3==3.11.4-r0 \
    py3-pip==23.1.2-r0 \
    util-linux==2.38.1-r8 # For uuidgen

COPY requirements.txt /tmp/requirements.txt
RUN pip3 install --no-cache-dir -r /tmp/requirements.txt && rm /tmp/requirements.txt

COPY .zshrc /root/.zshrc
COPY complete.py /usr/local/bin/complete.py

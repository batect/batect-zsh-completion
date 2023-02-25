FROM alpine:3.17.1@sha256:f271e74b17ced29b915d351685fd4644785c6d1559dd1f2d4189a5e851ef753a

RUN apk --no-cache add \
    bash==5.2.15-r0 \
    zsh==5.9-r0 \
    python3==3.10.10-r0 \
    py3-pip==22.3.1-r1 \
    util-linux==2.38.1-r1 # For uuidgen

COPY requirements.txt /tmp/requirements.txt
RUN pip3 install --no-cache-dir -r /tmp/requirements.txt && rm /tmp/requirements.txt

COPY .zshrc /root/.zshrc
COPY complete.py /usr/local/bin/complete.py

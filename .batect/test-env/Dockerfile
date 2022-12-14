FROM alpine:3.17.0@sha256:8914eb54f968791faf6a8638949e480fef81e697984fba772b3976835194c6d4

RUN apk --no-cache add \
    bash==5.2.15-r0 \
    zsh==5.9-r0 \
    python3==3.10.8-r3 \
    py3-pip==22.3.1-r1 \
    util-linux==2.38.1-r0 # For uuidgen

COPY requirements.txt /tmp/requirements.txt
RUN pip3 install --no-cache-dir -r /tmp/requirements.txt && rm /tmp/requirements.txt

COPY .zshrc /root/.zshrc
COPY complete.py /usr/local/bin/complete.py

FROM alpine:3.16.3@sha256:b95359c2505145f16c6aa384f9cc74eeff78eb36d308ca4fd902eeeb0a0b161b

RUN apk --no-cache add \
    bash==5.1.16-r2 \
    zsh==5.8.1-r4 \
    python3==3.10.8-r0 \
    py3-pip==22.1.1-r0 \
    util-linux==2.38-r1 # For uuidgen

COPY requirements.txt /tmp/requirements.txt
RUN pip3 install --no-cache-dir -r /tmp/requirements.txt && rm /tmp/requirements.txt

COPY .zshrc /root/.zshrc
COPY complete.py /usr/local/bin/complete.py

FROM alpine:3.17.2@sha256:69665d02cb32192e52e07644d76bc6f25abeb5410edc1c7a81a10ba3f0efb90a

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

FROM alpine:3.16.2@sha256:bc41182d7ef5ffc53a40b044e725193bc10142a1243f395ee852a8d9730fc2ad

RUN apk --no-cache add \
    bash==5.1.16-r2 \
    zsh==5.8.1-r4 \
    python3==3.10.5-r0 \
    py3-pip==22.1.1-r0 \
    util-linux==2.38-r1 # For uuidgen

COPY requirements.txt /tmp/requirements.txt
RUN pip3 install --no-cache-dir -r /tmp/requirements.txt && rm /tmp/requirements.txt

COPY .zshrc /root/.zshrc
COPY complete.py /usr/local/bin/complete.py

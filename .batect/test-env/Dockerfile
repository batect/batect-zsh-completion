FROM alpine:3.16.0@sha256:686d8c9dfa6f3ccfc8230bc3178d23f84eeaf7e457f36f271ab1acc53015037c

RUN apk --no-cache add \
    bash==5.1.16-r2 \
    zsh==5.8.1-r4 \
    python3==3.10.4-r0 \
    py3-pip==22.1.1-r0 \
    util-linux==2.38-r1 # For uuidgen

COPY requirements.txt /tmp/requirements.txt
RUN pip3 install --no-cache-dir -r /tmp/requirements.txt && rm /tmp/requirements.txt

COPY .zshrc /root/.zshrc
COPY complete.py /usr/local/bin/complete.py

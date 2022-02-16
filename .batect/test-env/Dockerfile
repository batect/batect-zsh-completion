FROM alpine:3.15.0@sha256:21a3deaa0d32a8057914f36584b5288d2e5ecc984380bc0118285c70fa8c9300

RUN apk --no-cache add \
    bash==5.1.8-r0 \
    zsh==5.8.1-r0 \
    python3==3.9.7-r4 \
    util-linux==2.37.4-r0 # For uuidgen

COPY zshrc /root/.zshrc
COPY complete.zsh /usr/local/bin/complete.zsh

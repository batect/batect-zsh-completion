FROM alpine:3.15.0@sha256:21a3deaa0d32a8057914f36584b5288d2e5ecc984380bc0118285c70fa8c9300

RUN apk --no-cache add \
    bash==5.1.4-r0 \
    zsh==5.8-r2 \
    python3==3.9.5-r2 \
    util-linux==2.37.2-r0 # For uuidgen

COPY zshrc /root/.zshrc
COPY complete.zsh /usr/local/bin/complete.zsh

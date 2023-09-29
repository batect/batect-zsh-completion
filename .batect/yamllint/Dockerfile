FROM alpine:3.18.4@sha256:eece025e432126ce23f223450a0326fbebde39cdf496a85d8c016293fc851978

RUN apk add --no-cache yamllint=1.31.0-r0

COPY bundle-default.yml /root/.config/yamllint/config

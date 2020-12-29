FROM alpine:3.12.3@sha256:074d3636ebda6dd446d0d00304c4454f468237fdacf08fb0eeac90bdbfa1bac7

RUN apk --no-cache add \
    bash==5.0.17-r0 \
    zsh==5.8-r1 \
    python3==3.8.5-r0

ADD https://raw.githubusercontent.com/Valodim/zsh-capture-completion/740fce754393513d57408bc585fde14e4404ba5a/capture.zsh /usr/local/bin/capture-completions.zsh
RUN chmod +x /usr/local/bin/capture-completions.zsh

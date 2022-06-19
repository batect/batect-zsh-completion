autoload -Uz compinit
compinit -u

zstyle ':completion:*:messages' format 'Message: %d'

# Useful for debugging: shows when completion functions generate no suggestions.
# zstyle ':completion:*:warnings' format 'Warning: %d'

# Don't show "do you wish to see all possibilities?" prompt
zstyle ':completion:*' list-prompt   ''

zstyle ':completion:*:default' format '%BCompleting %d:%b'

PROMPT='PROMPT-LINE > '

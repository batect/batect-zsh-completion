#! /usr/bin/env zsh

set -euo pipefail

# What is this?
# This is a script that simulates a tab completion for a given command line and returns the suggestions generated.
# zsh doesn't have a nice way to do this (like Fish's "complete -C'...'"), so we start a pseudo-TTY, write the command,
# send a tab character, then press backspace a bunch (to clear the command line) and exit the terminal.
# It's a horrible hack.
# Amongst other things, this doesn't work (and hangs) if multiple suggestions with common suffixes are matched (eg. './batect -' generates
# suggestions '--one-thing', '--other-thing', which zsh then completes to './batect --o-thing', with the cursor after the 'o').

TEST_PTY_NAME=test-pty
LINE_TO_COMPLETE="$1"

function main() {
    startPTY
    triggerCompletion

    deletePromptContents
    output=$(exitPTYAndCaptureContent)

    # This part relies on the customised prompt set in ~/.zshrc.
    count=$(echo "$output" | grep -c "PROMPT-LINE")

    case $count in
    1)
        handleZeroOrOneSuggestion "$output"
        ;;
    2)
        # Two prompts means there were multiple suggestions. The suggestions will be between the prompts.
        handleMultipleSuggestions "$output"
        ;;
    *)
        echo "Completion simulation script couldn't find expected number of prompts in output!" >/dev/stderr
        echo "Output was:" >/dev/stderr
        echo "-----------------------------------" >/dev/stderr
        echo "$output" >/dev/stderr
        echo "-----------------------------------" >/dev/stderr
        echo "Don't forget that your terminal may be processing (and therefore hiding) escape sequences and special characters in the output (eg. backspace and carriage return characters)" >/dev/stderr
        exit 1
        ;;
    esac
}

function startPTY() {
    zmodload zsh/zpty
    TERM=dumb zpty $TEST_PTY_NAME zsh --alwayslastprompt
}

function triggerCompletion() {
   zpty -w -n $TEST_PTY_NAME "$LINE_TO_COMPLETE"$'\t'
}

function deletePromptContents() {
    for x in 1 2 3 4 5; do
        zpty -w -n $TEST_PTY_NAME $'\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b'
    done
}

function exitPTYAndCaptureContent() {
    zpty -w -n $TEST_PTY_NAME $'exit\n'
    output=$(zpty -r $TEST_PTY_NAME)
    zpty -d $TEST_PTY_NAME

    echo $output
}

#  * If there's one suggestion, the prompt line will have been edited in place, then deleted with all of our
#    backspace characters above. Extract the new command line and then get the last argument to get the suggestion.
#  * If there are no suggestions, the prompt line will contain a bell (hex 0x07) and contain the command line
#    unmodified (before we try to then backspace it above).
function handleZeroOrOneSuggestion() {
    output="$1"

    line=$(echo "$output" | grep "PROMPT-LINE")
    afterPrompt=$(echo "$line" | sed -e 's/.*PROMPT-LINE .* > \x1b\[?2004h//g')
    withoutTrailingBackspaceCharacters=$(echo "$afterPrompt" | sed -e 's/\s*\x08.*//g')

    if [[ $withoutTrailingBackspaceCharacters =~ "\x07" ]]; then
        # Line contains a bell character and therefore there are no suggestions. Stop.
        exit 0
    fi

    splitToArguments "$withoutTrailingBackspaceCharacters" | tail -n1
}

# See https://superuser.com/a/1066541 for an explanation of this.
function splitToArguments() {
    line="$1"

    eval "for word in $line; do echo \$word; done"
}

# When there are multiple suggestions, they are formatted like this:
#  --check           -c  -- verify MD5 checksums from input files
#  --help                -- display help information
#                    -v  -- verbose output
# Or if there are only short options:
#  -v  -- verbose output
# Or if there are no descriptions for any option:
#  --do-thing     --other-stuff  --other-thing
function handleMultipleSuggestions() {
    output="$1"
    promptLines=$(echo "$output" | awk '/PROMPT-LINE/{print NR}')
    firstPromptLine=$(echo "$promptLines" | head -1)
    lastPromptLine=$(echo "$promptLines" | tail -1)
    suggestionLines=$(echo "$output" | outputBetweenLines "$firstPromptLine" "$lastPromptLine" | stripDescriptions)

    splitGroupedSuggestions "$suggestionLines"
}

function outputBetweenLines() {
    firstLine="$1"
    lastLine="$2"

    tail -n "+$((firstLine+1))" | head -n $((lastLine-firstLine-1))
}

function stripDescriptions() {
    sed -e 's/  -- .*//g'
}

function splitGroupedSuggestions() {
    lines="$1"

    echo "$lines" | while IFS= read -r line; do
        if [[ "$line" =~ "Message: " || "$line" =~ "Warning: " ]]; then
            # Line isn't actually a suggestion - it's a warning or a message.
            echo "$line" > /dev/stderr
            continue
        fi

        # This is quite fragile and will fail if any suggestions contain spaces.
        words=(${(s: :)line})

        for word in "${words[@]}"; do
            # Why use 'cat' and not 'echo'? 'echo' interprets some inputs (eg. '-n') as arguments for itself rather than desired output.
            cat <<< "$word"
        done
    done
}

main

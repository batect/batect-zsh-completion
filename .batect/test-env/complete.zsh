#! /usr/bin/env zsh

set -euo pipefail

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

    # TODO: get last suggestion
    echo "$withoutTrailingBackspaceCharacters"
}

function handleMultipleSuggestions() {
    output="$1"
    promptLines=$(echo "$output" | awk '/PROMPT-LINE/{print NR}')
    firstPromptLine=$(echo "$promptLines" | head -1)
    lastPromptLine=$(echo "$promptLines" | tail -1)

    echo "$output" | tail -n "+$((firstPromptLine+1))" | head -n $((lastPromptLine-firstPromptLine-1))
}

main

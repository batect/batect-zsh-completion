#! /usr/bin/env zsh

set -euo pipefail

TEST_PTY_NAME=test-pty
LINE_TO_COMPLETE="$1"

zmodload zsh/zpty

{
	TERM=dumb zpty $TEST_PTY_NAME zsh --alwayslastprompt
	zpty -w -n $TEST_PTY_NAME "$LINE_TO_COMPLETE"$'\t'

	for x in 1 2 3 4 5; do
	    zpty -w -n $TEST_PTY_NAME $'\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b'
    done

	zpty -w -n $TEST_PTY_NAME $'exit\n'
	output=$(zpty -r $TEST_PTY_NAME)

	# This part relies on the customised prompt set in ~/.zshrc.
	count=$(echo "$output" | grep -c "PROMPT-LINE")

    case $count in
    1)
        # One prompt means there was a single unambiguous suggestion. The prompt line will have been edited in place,
        # then deleted with all of our backspace characters above. Extract the new command line and then get the last argument to get the suggestion.
        line=$(echo "$output" | grep "PROMPT-LINE")
        afterPrompt=$(echo "$line" | sed -e 's/.*PROMPT-LINE .* > \x1b\[?2004h//g')
        withoutTrailingBackspaceCharacters=$(echo "$afterPrompt" | sed -e 's/\s*\x08.*//g')
        echo "$withoutTrailingBackspaceCharacters"

        # TODO: get last suggestion
        ;;
    2)
        # Two prompts means there wasn't a single unambiguous suggestion. If there are any suggestions, they'll be between the prompts.
        promptLines=$(echo "$output" | awk '/PROMPT-LINE/{print NR}')
        firstPromptLine=$(echo "$promptLines" | head -1)
        lastPromptLine=$(echo "$promptLines" | tail -1)

        echo "$output" | tail -n "+$((firstPromptLine+1))" | head -n $((lastPromptLine-firstPromptLine-1))
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
} always {
	zpty -d $TEST_PTY_NAME
}

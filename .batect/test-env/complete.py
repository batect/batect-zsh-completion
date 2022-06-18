#! /usr/bin/env python3

import argparse
import time

import pexpect

# What is this?
# This is a script that simulates a tab completion for a given command line and returns the suggestions generated.
# zsh doesn't have a nice way to do this (like Fish's "complete -C'...'"), so we start a pseudo-TTY, write the command,
# send a tab character, then exit the shell.
# It's a horrible hack.
# Amongst other things, this doesn't work (and hangs) if multiple suggestions with common suffixes are matched
# (eg. './batect -' generates suggestions '--one-thing', '--other-thing', which zsh then completes to
# './batect --o-thing', with the cursor after the 'o').


command_start_marker = "\x1b[?2004h"
command_end_marker = "\x1b[?2004l"


def main():
    line_to_complete = read_arguments()

    child = pexpect.spawn(
        "zsh",
        ["--alwayslastprompt"],
        env={
            "TERM": "dumb",
        },
        echo=False,
        timeout=5,
        dimensions=(1000, 300)
    )

    child.expect("PROMPT-LINE")
    child.send(line_to_complete)
    child.send("\t")

    time.sleep(0.1)

    child.sendcontrol("c")
    child.sendline()
    child.sendline("exit")

    output = child.read().decode()

    if not child.terminate(force=True):
        raise Exception("Couldn't terminate application")

    for suggestion in extract_suggestions_from_output(output, line_to_complete):
        print(suggestion)


def read_arguments():
    parser = argparse.ArgumentParser()
    parser.add_argument('line_to_complete')

    args = parser.parse_args()

    return args.line_to_complete


def extract_suggestions_from_output(output, original_line_to_complete):
    after_first_prompt = output[output.index("> "):]
    without_next_prompt = after_first_prompt[:after_first_prompt.index("PROMPT-LINE")]
    lines = without_next_prompt.splitlines()
    prompt_line = lines[0]
    suggestions = []

    if prompt_line.endswith(command_end_marker):
        # Command has been edited in place, so there is zero or one suggestion in the prompt line.
        # Extract the suggestion (if there is one) and return it.
        command_start_index = prompt_line.index(command_start_marker) + len(command_start_marker)
        command_end_index = prompt_line.rindex(command_end_marker)
        edited_command = prompt_line[command_start_index:command_end_index].rstrip()

        if edited_command != original_line_to_complete:
            suggestion = edited_command.split()[-1]
            suggestions.append(suggestion)
    else:
        # Prompt line has not been edited in place, so there are multiple suggestions printed below the original
        # prompt line.

        for line in lines[1:]:
            suggestions.extend(extract_suggestions_from_line(line.strip()))

    return suggestions


# Take a line such as "--binary          -b  -- read in binary mode" or "-S  -- sort by size",
# and extract just the arguments (eg. --binary, -b or -S)
def extract_suggestions_from_line(line):
    argument_names = line

    if " -- " in line:
        argument_names = line[:line.index(" -- ")]

    return argument_names.split()


if __name__ == '__main__':
    main()

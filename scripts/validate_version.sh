#! /usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

function main() {
    VERSION_IN_SCRIPT=$(getVersionInScript)
    echo "Version in script: $VERSION_IN_SCRIPT"

    GIT_TAG=$(getGitTag)
    echo "Git tag: $GIT_TAG"

    if [ "$VERSION_IN_SCRIPT" == "$GIT_TAG" ]; then
        echo "Everything looks good."
        exit 0
    else
        echo "Version in file does not match tag!"
        exit 1
    fi
}

function getVersionInScript() {
    sed -E -n 's/export BATECT_COMPLETION_PROXY_VERSION=\"(.*)\"/\1/p' "$ROOT_DIR/completions/_batect" | tr -d " "
}

function getGitTag() {
    git describe --dirty --candidates=0
}

main

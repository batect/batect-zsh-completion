#! /usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

function main() {
    if [ $# -ne 1 ]; then
        echo "Please provide the new version number as an argument to this script."
        exit 1
    fi

    THIS_VERSION=$1
    NEXT_VERSION=$(generateDevVersion "$THIS_VERSION")

    echo "Preparing release $THIS_VERSION..."
    echo "> Updating version in files to $THIS_VERSION..."
    updateVersion "$THIS_VERSION"
    echo "> Committing and creating tag..."
    commit "Release $THIS_VERSION."
    tag "$THIS_VERSION"
    echo
    echo "Release prepared, resetting repo for next release..."
    echo "> Updating version in files to $NEXT_VERSION..."
    updateVersion "$NEXT_VERSION"
    echo "> Committing..."
    commit "Prepare for next release."
    echo "Done."
    echo
    echo "Run 'git push && git push origin $THIS_VERSION' to publish this release."
}

function updateVersion() {
    VERSION=$1

    sed -i '' -E "s/export BATECT_COMPLETION_PROXY_VERSION=\".*\"/export BATECT_COMPLETION_PROXY_VERSION=\"$VERSION\"/g" "$ROOT_DIR/_batect"
    sed -i '' -E "s/EXPECTED_PROXY_VERSION = \".*\"/EXPECTED_PROXY_VERSION = \"$VERSION\"/g" "$ROOT_DIR/tests/tests.py"
}

function commit() {
    COMMIT_MESSAGE=$1

    git add "$ROOT_DIR/_batect"
    git add "$ROOT_DIR/tests/tests.py"
    git commit -m "$COMMIT_MESSAGE"
}

function tag() {
    TAG=$1

    git tag -s "$TAG" -m "$TAG"
}

function generateDevVersion() {
    VERSION=$1
    MAJOR=$(echo "$VERSION" | cut -d. -f1)
    MINOR=$(echo "$VERSION" | cut -d. -f2)
    NEW_MINOR=$((MINOR+1))

    echo "$MAJOR.$NEW_MINOR.0-dev"
}

main "$@"

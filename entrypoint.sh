#!/bin/bash

set -eu

_main() {
    _switch_to_repository

    _setup_git

    _switch_to_branch

    _empty_commit

    _push_to_github
}


_switch_to_repository() {
    echo "INPUT_REPOSITORY value: $INPUT_REPOSITORY";
    cd $INPUT_REPOSITORY
}

# Set up git user configuration
_setup_git ( ) {
    git config --global user.name "$INPUT_COMMIT_USER_NAME"
    git config --global user.email "$INPUT_COMMIT_USER_EMAIL"
}

_switch_to_branch() {
    echo "INPUT_BRANCH value: $INPUT_BRANCH";

    # Switch to branch from current Workflow run
    git checkout $INPUT_BRANCH
}

_empty_commit() {
    git commit -m "$INPUT_COMMIT_MESSAGE" --author="$INPUT_COMMIT_AUTHOR" --allow-empty
}

_push_to_github() {
    if [ -z "$INPUT_BRANCH" ]
    then
        git push origin
    else
        git push --set-upstream origin "HEAD:$INPUT_BRANCH"
    fi
}

_main

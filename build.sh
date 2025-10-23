#!/bin/sh
set -x

REPO_DIR=$GITHUB_WORKSPACE
if [ -z $REPO_DIR ]; then REPO_DIR=.; fi

PROJECT_NAME=hello

current_path="$(realpath .)"
cd $REPO_DIR/$PROJECT_NAME
gcc hello.c -o runhello
zip --symlinks -r "$current_path/hello-bin.zip" runhello >/dev/null
cd $current_path

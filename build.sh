#!/bin/sh
set -x

REPO_DIR=$GITHUB_WORKSPACE
if [ -z $REPO_DIR ]; then REPO_DIR=.; fi

PROJECT_NAME=hello
BUILD_DIR=_build

rm -rf $REPO_DIR/$PROJECT_NAME/$BUILD_DIR
mkdir -p $REPO_DIR/$PROJECT_NAME/$BUILD_DIR

cmake -S $REPO_DIR/$PROJECT_NAME -B $REPO_DIR/$PROJECT_NAME/$BUILD_DIR -D CMAKE_BUILD_TYPE=Release
if [ $? -ne 0 ]; then exit 1; fi

cmake --build $REPO_DIR/$PROJECT_NAME/$BUILD_DIR -- -j$(nproc)
if [ $? -ne 0 ]; then exit 1; fi

current_path="$(realpath .)"
cd $REPO_DIR/$PROJECT_NAME/$BUILD_DIR
zip --symlinks -r "$current_path/hello-bin.zip" runhello >/dev/null
cd $current_path

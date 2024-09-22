#!/usr/bin/env bash

set -euo pipefail

subdir=${1:-""}
filename=${2:-""}

if [[ $subdir == "--help" ]]; then
    echo "Copy files from assertion_failures to assertions."
    echo ""
    echo "Usage:"
    echo "accept_assertions.sh                   Recursively copies all subdirectories from assertion_failures to assertions"
    echo "accept_assertions.sh dir               Copies all files from assertion_failures/dir to assertions/dir"
    echo "accept_assertions.sh dir file.html     Copies file assertion_failures/dir/file.html to assertions/dir/file.html"
    echo ""
    exit 0
fi

origin_dir="test/assertion_failures"
destination_dir="test/assertions"

joinByChar() {
    local IFS="$1"
    shift
    echo "$*"
}

destination_path="$(joinByChar "/" $destination_dir $subdir)"
mkdir -p $destination_path

if [[ $subdir == "" ]]; then
    origin_path="$(joinByChar "/" $origin_dir "*")"
elif [[ $filename == "" ]]; then
    origin_path="$(joinByChar "/" $origin_dir $subdir "*.html")"
else
    origin_path="$(joinByChar "/" $origin_dir $subdir $filename)"
fi

rsync -a --remove-source-files --exclude='README.md' $origin_path $destination_path 2>&1 >/dev/null
find $origin_dir -type d -empty -delete

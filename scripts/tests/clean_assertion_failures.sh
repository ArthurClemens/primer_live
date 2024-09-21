#!/usr/bin/env bash

set -euo pipefail

origin_dir="test/assertion_failures"

find $origin_dir -maxdepth 1 -mindepth 1 -type d -exec rm -rf '{}' \;

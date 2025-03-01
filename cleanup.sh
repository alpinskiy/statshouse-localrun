#!/bin/bash

ROOT_DIR=$(cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)
SRC_DIR=$ROOT_DIR/src
TMP_DIR=$ROOT_DIR/temp

# remove source directory if not a symlink
if ! [[ -L "$SRC_DIR" && -d "$SRC_DIR" ]]; then
    rm -rf "$SRC_DIR"
fi
rm -rf "$TMP_DIR"
rm -f "$ROOT_DIR/statshouse_api.pid"

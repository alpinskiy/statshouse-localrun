#!/bin/bash
set -e

ROOT_DIR=$(cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)/..
SCRIPT_DIR=$ROOT_DIR/bash
SRC_DIR=$ROOT_DIR/../statshouse

[[ -d $SRC_DIR ]] || $SCRIPT_DIR/clone.sh
cd $SRC_DIR && make build-main-daemons

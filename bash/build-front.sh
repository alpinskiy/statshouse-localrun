#!/bin/bash

ROOT_DIR=$(cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)/..
SCRIPT_DIR=$ROOT_DIR/bash
SRC_DIR=$ROOT_DIR/src

[[ -d $SRC_DIR ]] || $SCRIPT_DIR/clone.sh
cd $SRC_DIR && make build-sh-ui

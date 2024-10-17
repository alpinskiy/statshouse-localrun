#!/bin/bash

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)/..
SRC=$SCRIPT_DIR/src

git clone git@github.com:VKCOM/statshouse.git $SRC

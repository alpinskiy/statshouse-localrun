#!/bin/bash
set -e

ROOT_DIR=$(cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)/..
SRC_DIR=$ROOT_DIR/../statshouse
SCRIPT_DIR=$ROOT_DIR/bash
TMP_DIR=$ROOT_DIR/temp
CACHE_DIR=$TMP_DIR/agent-ingress

mkdir -p "$CACHE_DIR"
$SRC_DIR/target/statshouse agent\
 --cluster=default\
 --hostname=agent_ingress\
 -p=13334\
 --agg-addr=127.0.0.1:13327,127.0.0.1:13327,127.0.0.1:13327\
 --cache-dir="$CACHE_DIR"\
 --aes-pwd-file="$SCRIPT_DIR/ingress_keys/key1.txt"\
 "$@"

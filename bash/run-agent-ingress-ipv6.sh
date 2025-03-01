#!/bin/bash
set -e

ROOT_DIR=$(cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)/..
SRC_DIR=$ROOT_DIR/../statshouse
SCRIPT_DIR=$ROOT_DIR/bash
TMP_DIR=$ROOT_DIR/temp
CACHE_DIR=$TMP_DIR/agent-ingress-ipv6

mkdir -p "$CACHE_DIR"
$SRC_DIR/target/statshouse agent\
 --cluster=default\
 --hostname=agent_ingress_ipv6\
 -p=13334\
 --agg-addr="[::1]:13317,[::1]:13317,[::1]:13317"\
 --cache-dir="$CACHE_DIR"\
 --aes-pwd-file="$SCRIPT_DIR/ingress_keys/key1.txt"\
 "$@"

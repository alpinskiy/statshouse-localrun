#!/bin/bash
set -e

ROOT_DIR=$(cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)/..
SRC_DIR=$ROOT_DIR/src
TMP_DIR=$ROOT_DIR/bash/tmp
SCRIPT_DIR=$ROOT_DIR/bash

$SRC_DIR/target/statshouse-igp \
 --cluster=default\
 --ingress-addr=127.0.0.1:13327\
 --agg-addr=127.0.0.1:13336,127.0.0.1:13346,127.0.0.1:13356\
 --ingress-external-addr=127.0.0.1:13327\
 --ingress-pwd-dir="$SCRIPT_DIR/ingress_keys"\
 --ingress-version=2\
 "$@"

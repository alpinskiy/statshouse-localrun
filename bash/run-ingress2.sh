#!/bin/bash
set -e

ROOT_DIR=$(cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)/..
SRC_DIR=$ROOT_DIR/../statshouse
TMP_DIR=$ROOT_DIR/temp
SCRIPT_DIR=$ROOT_DIR/bash

SRC_DIR/target/statshouse-igp \
 --cluster=default\
 --agg-addr="[::1]:13327,[::1]:13327,[::1]:13327"\
 --ingress-addr-ipv6="[::1]:13317"\
 --ingress-external-addr-ipv6="[::1]:13317"\
 --aes-pwd-file="$SCRIPT_DIR/ingress_keys/key1.txt"\
 --ingress-pwd-dir="$SCRIPT_DIR/ingress_keys"\
 --ingress-version=2\
 "$@"

#!/bin/bash
set -e

ROOT_DIR=$(cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)/..
SRC_DIR=$ROOT_DIR/src
TMP_DIR=$ROOT_DIR/bash/tmp
SCRIPT_DIR=$ROOT_DIR/bash

$SRC_DIR/target/statshouse ingress_proxy\
 --cluster=default\
 --hostname=ingress2\
 --agg-addr="[::1]:13327,[::1]:13327,[::1]:13327"\
 --ingress-addr-ipv6="[::1]:13317"\
 --ingress-external-addr-ipv6="[::1]:13317"\
 --aes-pwd-file="$SCRIPT_DIR/ingress_keys/key1.txt"\
 --ingress-pwd-dir="$SCRIPT_DIR/ingress_keys"\
 --ingress-version=2\
 "$@"

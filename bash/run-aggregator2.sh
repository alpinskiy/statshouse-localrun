#!/bin/bash
set -e

ROOT_DIR=$(cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)/..
SRC_DIR=$ROOT_DIR/../statshouse
TMP_DIR=$ROOT_DIR/temp
CACHE_DIR=$TMP_DIR/aggregator2

mkdir -p $CACHE_DIR
$SRC_DIR/target/statshouse-agg --aggregator\
 --auto-create=1\
 --auto-create-default-namespace=1\
 --agg-addr=127.0.0.1:13336,127.0.0.1:13346,127.0.0.1:13356\
 --local-replica=2\
 --cluster=default\
 --kh=127.0.0.1:8123\
 --metadata-addr="127.0.0.1:2442"\
 --cache-dir="$CACHE_DIR"\
 "$@"

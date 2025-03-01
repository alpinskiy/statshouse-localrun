#!/bin/bash
set -e

ROOT_DIR=$(cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)/..
SRC_DIR=$ROOT_DIR/../statshouse
TMP_DIR=$ROOT_DIR/temp
CACHE_DIR=$TMP_DIR/aggregator1

mkdir -p $CACHE_DIR
$SRC_DIR/target/statshouse-agg aggregator\
 --auto-create\
 --agg-addr=localhost:13336\
 --cluster=default\
 --kh=localhost:8123\
 --metadata-addr=localhost:2442\
 --cache-dir="$CACHE_DIR"\
 "$@"

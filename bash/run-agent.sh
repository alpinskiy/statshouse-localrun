#!/bin/bash
set -e

ROOT_DIR=$(cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)/..
SRC_DIR=$ROOT_DIR/src
TMP_DIR=$ROOT_DIR/bash/tmp
CACHE_DIR=$TMP_DIR/agent

mkdir -p $CACHE_DIR
$SRC_DIR/target/statshouse -agent\
 --cluster=default\
 --hostname=agent1\
 --hardware-metric-scrape-disable\
 --agg-addr=127.0.0.1:13336,127.0.0.1:13336,127.0.0.1:13336\
 --cache-dir="$CACHE_DIR"\
 "$@"

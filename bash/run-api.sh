#!/bin/bash
set -e

ROOT_DIR=$(cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)/..
SRC_DIR=$ROOT_DIR/src
TMP_DIR=$ROOT_DIR/bash/tmp
CACHE_DIR=$TMP_DIR/api

mkdir -p $CACHE_DIR
$SRC_DIR/target/statshouse-api\
 --local-mode=1\
 --insecure-mode=1\
 --clickhouse-v1-addrs= --clickhouse-v2-addrs=localhost:9000\
 --listen-addr=localhost:10888\
 --static-dir=$SRC_DIR/statshouse-ui/build\
 --metadata-addr="127.0.0.1:2442"\
 --disk-cache="$CACHE_DIR/mapping_cache.sqlite3"\
 "$@"

#!/usr/bin/env bash

set -e
trap 'pkill -P $$' SIGINT SIGTERM

ROOT=$(cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)
DATA_ROOT=$ROOT/data
INGRESS_ADDR=127.0.0.1:13327
STATSHOUSE_ROOT=$ROOT/../statshouse

for port in $(seq 13339 13349); do
    HOSTNAME=agent$port
    CACHE_DIR=$DATA_ROOT/$HOSTNAME
    mkdir -p $CACHE_DIR
    $STATSHOUSE_ROOT/target/statshouse agent -p=$port --cluster=test_shard_localhost --hostname=$HOSTNAME \
        --agg-addr=$INGRESS_ADDR,$INGRESS_ADDR,$INGRESS_ADDR --cache-dir=$CACHE_DIR --aes-pwd-file=$ROOT/ingress_keys/key1.txt \
        --hardware-metric-scrape-disable &
done

wait -n

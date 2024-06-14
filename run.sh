#!/usr/bin/env bash

set -e
ROOT=$(cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)
DATA_ROOT=$ROOT/data
STATSHOUSE_ROOT=$ROOT/../statshouse

trap 'pkill -P $$' SIGINT SIGTERM

# clickhouse
docker compose -f $ROOT/clickhouse.yml up &

# metadata
METADATA_ROOT=$DATA_ROOT/metadata
METADATA_DB=$METADATA_ROOT/db
METADATA_BINLOG=$METADATA_ROOT/binlog
METADATA_BINLOG_PREFIX=$METADATA_BINLOG/bl
mkdir -p $METADATA_BINLOG
if [ -z "$(ls -A $METADATA_BINLOG)" ]; then
  $STATSHOUSE_ROOT/target/statshouse-metadata -p 2442 --db-path $METADATA_DB --binlog-prefix $METADATA_BINLOG_PREFIX --create-binlog "0,1"
fi
$STATSHOUSE_ROOT/target/statshouse-metadata -p 2442 --db-path $METADATA_DB --binlog-prefix $METADATA_BINLOG_PREFIX &

# aggregator
AGGREGATOR_CACHE=$DATA_ROOT/aggregator
AGGREGATOR_ADDR=localhost:13336
mkdir -p $AGGREGATOR_CACHE
$STATSHOUSE_ROOT/target/statshouse aggregator --agg-addr=$AGGREGATOR_ADDR --cluster=test_shard_localhost --kh=localhost:8123 \
  --metadata-addr localhost:2442 --cache-dir=$AGGREGATOR_CACHE &

# agent
AGENT1_CACHE=$DATA_ROOT/agent1
mkdir -p $AGENT1_CACHE
$STATSHOUSE_ROOT/target/statshouse agent --cluster=test_shard_localhost --hostname=agent1 --agg-addr=$AGGREGATOR_ADDR,$AGGREGATOR_ADDR,$AGGREGATOR_ADDR \
  --cache-dir=$AGENT1_CACHE &

# api
API_CACHE_DIR=$DATA_ROOT/api
mkdir -p $API_CACHE_DIR
$STATSHOUSE_ROOT/target/statshouse-api --local-mode --access-log --clickhouse-v1-addrs= --clickhouse-v2-addrs=localhost:9000 \
  --verbose --listen-addr localhost:10888 --static-dir $STATSHOUSE_ROOT/statshouse-ui/build/ --metadata-addr localhost:2442 \
  --utc-offset=4 --disk-cache=$API_CACHE_DIR/mapping_cache.sqlite3 &

# ingress
INGRESS_ADDR=127.0.0.1:13327
$STATSHOUSE_ROOT/target/statshouse ingress_proxy --cluster=test_shard_localhost --hostname=ingress --ingress-addr=$INGRESS_ADDR --agg-addr=$AGGREGATOR_ADDR,$AGGREGATOR_ADDR,$AGGREGATOR_ADDR --ingress-external-addr=$INGRESS_ADDR,$INGRESS_ADDR,$INGRESS_ADDR --ingress-pwd-dir=ingress_keys &

# agent behind ingress
AGENT2_CACHE=$DATA_ROOT/agent2
mkdir -p $AGENT2_CACHE
$STATSHOUSE_ROOT/target/statshouse agent -p=13338 --cluster=test_shard_localhost --hostname=agent2 --agg-addr=$INGRESS_ADDR,$INGRESS_ADDR,$INGRESS_ADDR --cache-dir=$AGENT2_CACHE --aes-pwd-file=$ROOT/ingress_keys/key1.txt &

wait -n

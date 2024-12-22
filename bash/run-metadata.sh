#!/bin/bash
set -e

ROOT_DIR=$(cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)/..
SRC_DIR=$ROOT_DIR/src
TMP_DIR=$ROOT_DIR/bash/tmp
DB_DIR=$TMP_DIR/metadata
DB_PATH=$DB_DIR/db
BINLOG_PATH=$DB_DIR/binlog
BINLOG_PREFIX=$BINLOG_PATH/bl

[[ -d $BINLOG_PATH ]] || mkdir -p $BINLOG_PATH
if [ -z "$(ls -A $BINLOG_PATH)" ]; then
  $SRC_DIR/target/statshouse-metadata -p 2442 --db-path "$DB_PATH" --binlog-prefix "$BINLOG_PREFIX" --create-binlog "0,1"
fi

$SRC_DIR/target/statshouse-metadata\
 -p=2442\
 --db-path="$DB_PATH"\
 --binlog-prefix="$BINLOG_PREFIX"\
 "$@"

#!/bin/bash
set -e

ROOT_DIR=$(cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)
SCRIPT_DIR=$ROOT_DIR/bash
SRC_DIR=$ROOT_DIR/src

[[ -d $SRC_DIR/target ]] || $SCRIPT_DIR/build-back.sh
[[ -d $SRC_DIR/statshouse-ui/build ]] || $SCRIPT_DIR/build-front.sh

trap "trap - SIGTERM && kill -- -$$" SIGINT SIGTERM EXIT
$SCRIPT_DIR/run-metadata.sh&
# $SCRIPT_DIR/run-aggregator.sh&
$SCRIPT_DIR/run-aggregator1.sh&
$SCRIPT_DIR/run-aggregator2.sh&
$SCRIPT_DIR/run-aggregator3.sh&
$SCRIPT_DIR/run-agent.sh&
#$SCRIPT_DIR/run-ingress.sh&
#$SCRIPT_DIR/run-agent-ingress.sh&
$SCRIPT_DIR/run-api.sh&
wait -n

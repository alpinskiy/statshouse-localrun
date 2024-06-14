#!/usr/bin/env bash

set -e
STATSHOUSE_ROOT=../statshouse

cd $STATSHOUSE_ROOT && make build-main-daemons

#!/usr/bin/env bash

set -xe

awslocal kinesis create-stream \
    --stream-name demo \
    --shard-count 1

awslocal kinesis wait stream-exists \
    --stream-name demo

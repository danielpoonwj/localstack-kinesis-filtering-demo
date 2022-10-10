#!/usr/bin/env bash

set -e

export AWS_ACCESS_KEY_ID=dummy
export AWS_SECRET_ACCESS_KEY=dummy
export AWS_DEFAULT_REGION=us-east-1

aws --endpoint-url=http://localhost:4566 \
    kinesis put-record \
        --stream-name demo \
        --partition-key "$(uuidgen)" \
        --data "$(base64 samples/function-1.json)"

aws --endpoint-url=http://localhost:4566 \
    kinesis put-record \
        --stream-name demo \
        --partition-key "$(uuidgen)" \
        --data "$(base64 samples/function-2.json)"

sleep 3

echo
echo "===== Function 1 BEGIN ====="
aws --endpoint-url=http://localhost:4566 \
    logs tail /aws/lambda/localstack-kinesis-filtering-demo-dev-function-1
echo "===== Function 1 END ====="

echo
echo "===== Function 2 BEGIN ====="
aws --endpoint-url=http://localhost:4566 \
    logs tail /aws/lambda/localstack-kinesis-filtering-demo-dev-function-2
echo "===== Function 2 END ====="

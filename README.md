# Introduction

This is a demo project to showcase the issue [here](https://github.com/localstack/localstack/pull/6826) regarding Kinesis event filtering for Lambda.

This test scenario involves two Lambdas and `./test.sh` sends two messages. Based on the message filter it should result in one message being consumed by each Lambda.

With the current issue, no messages are reaching the Lambdas.

The expected output should look something like this:

```
$ ./test.sh

{
    "ShardId": "shardId-000000000000",
    "SequenceNumber": "49634095160813648470476629201485634161594744938996695042",
    "EncryptionType": "NONE"
}
{
    "ShardId": "shardId-000000000000",
    "SequenceNumber": "49634095160813648470476629201486843087414359636890877954",
    "EncryptionType": "NONE"
}

===== Function 1 BEGIN =====
2022-10-10T13:40:32.161000+00:00 2022/10/10/[LATEST]ce83ae28 START ee5b22cc-259b-4fb0-9370-5c2db5520ab1: Lambda arn:aws:lambda:us-east-1:000000000000:function:localstack-kinesis-filtering-demo-dev-function-1 started via "local" executor ...
2022-10-10T13:40:32.162000+00:00 2022/10/10/[LATEST]ce83ae28 [
2022-10-10T13:40:32.163000+00:00 2022/10/10/[LATEST]ce83ae28     {
2022-10-10T13:40:32.164000+00:00 2022/10/10/[LATEST]ce83ae28         "event_type": "function_1",
2022-10-10T13:40:32.166000+00:00 2022/10/10/[LATEST]ce83ae28         "message": "foo"
2022-10-10T13:40:32.167000+00:00 2022/10/10/[LATEST]ce83ae28     }
2022-10-10T13:40:32.168000+00:00 2022/10/10/[LATEST]ce83ae28 ]
2022-10-10T13:40:32.171000+00:00 2022/10/10/[LATEST]ce83ae28 END RequestId: ee5b22cc-259b-4fb0-9370-5c2db5520ab1
2022-10-10T13:40:32.172000+00:00 2022/10/10/[LATEST]ce83ae28 REPORT RequestId: ee5b22cc-259b-4fb0-9370-5c2db5520ab1 Duration: 47000 ms
===== Function 1 END =====

===== Function 2 BEGIN =====
2022-10-10T13:40:32.991000+00:00 2022/10/10/[LATEST]f0dd2197 START f75f444d-5ca8-43cb-ad02-45463a8c04f9: Lambda arn:aws:lambda:us-east-1:000000000000:function:localstack-kinesis-filtering-demo-dev-function-2 started via "local" executor ...
2022-10-10T13:40:32.993000+00:00 2022/10/10/[LATEST]f0dd2197 [
2022-10-10T13:40:32.995000+00:00 2022/10/10/[LATEST]f0dd2197     {
2022-10-10T13:40:32.997000+00:00 2022/10/10/[LATEST]f0dd2197         "event_type": "function_2",
2022-10-10T13:40:32.999000+00:00 2022/10/10/[LATEST]f0dd2197         "message": "bar"
2022-10-10T13:40:33.002000+00:00 2022/10/10/[LATEST]f0dd2197     }
2022-10-10T13:40:33.004000+00:00 2022/10/10/[LATEST]f0dd2197 ]
2022-10-10T13:40:33.008000+00:00 2022/10/10/[LATEST]f0dd2197 END RequestId: f75f444d-5ca8-43cb-ad02-45463a8c04f9
2022-10-10T13:40:33.010000+00:00 2022/10/10/[LATEST]f0dd2197 REPORT RequestId: f75f444d-5ca8-43cb-ad02-45463a8c04f9 Duration: 41000 ms
===== Function 2 END =====
```

# Setup

1. Start localstack docker

```bash
docker-compose up -d
```

2. Deploy Lambda functions

```bash
nvm use
npm ci

npx sls deploy
```

3. Run test scenario

```bash
./test.sh
```

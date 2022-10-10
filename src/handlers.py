from base64 import b64decode
import json


def _process_kinesis_records(event):
    for record in event["Records"]:
        raw_data = record["kinesis"]["data"]
        parsed_data = b64decode(raw_data.encode())
        yield json.loads(parsed_data.decode())

def function_1_handler(event, context):
    records_data = list(_process_kinesis_records(event))
    print(json.dumps(records_data, indent=4))

def function_2_handler(event, context):
    records_data = list(_process_kinesis_records(event))
    print(json.dumps(records_data, indent=4))

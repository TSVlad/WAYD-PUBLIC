import json


def json_serializer(data):
    return json.dumps(data).encode("utf-8")


def json_deserializer(data):
    return json.loads(data.decode('utf-8'))

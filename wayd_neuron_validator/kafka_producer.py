import os

from dotenv import load_dotenv
from kafka import KafkaProducer
from json_utils import json_serializer


load_dotenv('./.env')

producer = KafkaProducer(bootstrap_servers=[os.getenv('KAFKA_ADDRESS')],
                         value_serializer=json_serializer)


def send(message):
    producer.send("neuron-validator-topic", message)

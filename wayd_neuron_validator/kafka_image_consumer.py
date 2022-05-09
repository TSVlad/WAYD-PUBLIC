import os
from threading import Thread

from kafka import KafkaConsumer
import images_utils

import neiron_validator
from json_utils import json_deserializer
import kafka_producer
from neuron_validator_message import create_neuron_validator_message

consumer = KafkaConsumer('image-to-neuron-validator',
                         group_id='neuron-validator',
                         bootstrap_servers=[os.environ.get('KAFKA_ADDRESS')],
                         value_deserializer=json_deserializer)


def start_kafka_listening():
    thread = Thread(target=kafka_message_handler)
    thread.start()


def handle_new_image(message):
    print("<New image> message handle")
    res = 0
    if len(message.value['image']) > 0:
        img = images_utils.get_image_from_bytes(message.value['image'])
        res = neiron_validator.validate_image(img)
    message = create_neuron_validator_message('IMAGE_VALIDATED', message.value['imageDTO']['id'], 'VALID' if res < 0.5 else 'NOT_VALID')
    kafka_producer.send(message)


type_to_handler_dict = {
    'NEW_IMAGE': handle_new_image
}


def kafka_message_handler():
    print('Started kafka consumer')
    for message in consumer:
        type_to_handler_dict[message.value['type']](message)

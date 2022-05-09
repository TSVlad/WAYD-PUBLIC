
def create_neuron_validator_message(type, image_id, validity):
    return {
    'id': 0,
    'created': None,
    'userInfo': None,
    'imageId': image_id,
    'validity': validity,
    'type': type,
    }
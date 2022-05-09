import keras
import numpy as np

import images_utils

classifier = keras.models.load_model('model/5_kaggle.h5')


def validate_image(image):
    resized_image = images_utils.resize_image_to_square(image, 300)
    for_input = np.asarray([resized_image])
    return classifier.predict(for_input)[0][0]


import cv2
import base64
import numpy as np


def get_image_from_bytes(bytes):
    jpg_original = base64.b64decode(bytes)
    jpg_as_np = np.frombuffer(jpg_original, dtype=np.uint8)
    img = cv2.imdecode(jpg_as_np, flags=1)
    return img


def resize_image_to_square(img, size):
    diff = max([img.shape[0] - size, img.shape[1] - size])
    if diff > 0:
        img = cv2.resize(img, (0, 0), fx=size / (size + diff), fy=size / (size + diff))

    pad1 = size - img.shape[0]
    if pad1 < 0:
        pad1 = 0
    pad2 = size - img.shape[1]
    if pad2 < 0:
        pad2 = 0
    img = cv2.copyMakeBorder(img, int(pad1 / 2) + pad1 % 2, int(pad1 / 2), int(pad2 / 2) + pad2 % 2, int(pad2 / 2),
                             cv2.BORDER_CONSTANT)

    return img

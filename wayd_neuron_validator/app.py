import os

from flask import Flask
from kafka_image_consumer import start_kafka_listening

app = Flask(__name__)

start_kafka_listening()

if __name__ == '__main__':
    app.run(host='localhost', port=os.getenv('FLASK_RUN_PORT'))

# -*- coding:utf-8 -*-
# import the necessary packages
from threading import Thread
import cv2

class WebcamVideoStream:
    def __init__(self, src=0):
        # initialize the video camera stream and read the first frame
        # from the stream
        print("init")
        self.stream = cv2.VideoCapture("27.96.135.124:8000")

    def __del__(self):
        self.stream.release()

    def get_frame(self):
        ret, frame = self.stream.read()
        ret, jpeg = cv2.imencode('.jpg', frame)
        return jpeg.tobytes()


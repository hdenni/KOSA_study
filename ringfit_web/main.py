# -*- coding:utf-8 -*-
#!usr/bin env python

from flask import Flask, render_template, Response

# emurated camera
from webcamvideostream import WebcamVideoStream

import cv2

app = Flask(__name__)
video = WebcamVideoStream()

@app.route('/')
def index():
    return render_template("home.html")

def generate(camera):
    while True:
        frame = camera.get_frame()

        yield(b'--frame\r\n'
              b'Content-Type: image/jpg\r\n\r\n' + jpg.tobytes() + b'\r\n')

@app.route('/video_feed')
def video_feed():
    return Response(generate(video),
                    mimetype="multipart/x-mixed-replace; boundary=frame")

if __name__=='__main__':
    app.run(host="0.0.0.0", port=8000, debug=True, threaded=True)

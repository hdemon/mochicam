#!/bin/sh

sudo ffmpeg -f alsa -ac 1 -thread_queue_size 8192 -i hw:1,0 \
            -f v4l2 -thread_queue_size 8192 -input_format yuyv422 \
            -i /dev/video0 -c:v h264_omx \
            -framerate 60 \
            -video_size 1024x768 \
            -c:v h264_omx \
            -b:v 768k -bufsize 768k \
            -vsync 1 -g 16 \
            -c:a aac -b:a 64k -ar 44100 -af "volume=30dB" \
            -f flv rtmp://localhost/live/stream

#  -f alsa -ac 1 -thread_queue_size 8192 \
#             -i hw:1 -f v4l2 -thread_queue_size 8192 \
#             -f flv rtmp://localhost/live/stream \
#             -f v4l2 -thread_queue_size 8192 \
#             -i /dev/video0 -c:v h264_omx \
#             -framerate 60 \
#             -video_size 1024x768 \
#             -c:v h264_omx \
#             -b:v 768k \
#             -bufsize 768k \
#             -vsync 2 \
#             -g 16 \
#             -input_format yuyv422 \
#             -c:a aac -b:a 128k -ar 44100 -af "volume=30dB"

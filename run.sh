#!/bin/sh

stream() {
	sleep 1m
	cd /home/pi/picam_streaming
	URL=$(cat url.txt)
	echo "PiCam streaming url: rtmp://a.rtmp.youtube.com/live2/$URL"
	(raspivid -n -o - -t 0 -w 1280 -h 720 -fps 25 -b 4000000 -g 50 | ./arm-ffmpeg/bin/ffmpeg -re -ar 44100 -ac 2 -acodec pcm_s16le -f s16le -ac 2 -i /dev/zero -f h264 -i - -vcodec copy -acodec aac -ab 128k -g 50 -strict experimental -f flv rtmp://a.rtmp.youtube.com/live2/$URL > /dev/null &)
	echo "PiCam youtube stream started"
}

echo "Waiting 1 minute to launch picam streaming"
stream &

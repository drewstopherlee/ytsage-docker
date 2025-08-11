#!/bin/bash
set -e

DISPLAY_NUM=:99
SCREEN_RES=1280x720x24

# Start X virtual framebuffer (headless X server)
echo "Starting Xvfb on $DISPLAY_NUM with resolution $SCREEN_RES" && \
Xvfb $DISPLAY_NUM -screen 0 $SCREEN_RES &

# Wait a few seconds for X to be ready
sleep 3

export DISPLAY=$DISPLAY_NUM
echo "DISPLAY set to $DISPLAY"

# Start window manager (fluxbox)
echo "Starting fluxbox window manager" && \
fluxbox &

# Start x11vnc server, quiet mode, no password, forever, share desktop
echo "Starting x11vnc server on $DISPLAY_NUM, quiet mode" && \
x11vnc -display $DISPLAY -nopw -forever -shared -quiet -ncache 10 -rfbport 5900 &

# Start noVNC websockify proxy on port 8080
echo "Starting websockify noVNC proxy on port 8080, exposing /" && \
websockify --web=/usr/share/novnc 8080 localhost:5900

# Start your Python app (replace with your actual command)
echo "Starting YTSage" && \
/usr/bin/python3 main.py

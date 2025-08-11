#!/bin/bash
# Start a virtual X server
Xvfb :99 -screen 0 1920x1080x24 &

# Start a lightweight window manager
fluxbox &

# Start x11vnc server
x11vnc -display :99 -nopw -forever &

# Start noVNC
websockify --web /opt/novnc 8080 localhost:5900 &

# Launch YTSage GUI
export DISPLAY=:99
python main.py

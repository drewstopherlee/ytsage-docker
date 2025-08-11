#!/bin/bash
set -e

# Start X virtual framebuffer (headless X server)
Xvfb :99 -screen 0 1280x720x24 &

# Start window manager (fluxbox)
fluxbox &

# Wait a few seconds for X to be ready
sleep 3

# Start x11vnc server, quiet mode, no password, forever, share desktop
x11vnc -display :99 -nopw -forever -shared -quiet -ncache 10 -rfbport 5900 &

# Start noVNC websockify proxy on port 8080
/usr/share/novnc/utils/novnc_proxy --vnc localhost:5900 --listen 8080 --web /usr/share/novnc &

# Start your Python app (replace with your actual command)
/usr/bin/python3 main.py

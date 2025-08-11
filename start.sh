#!/bin/bash
export DISPLAY=:99
echo "DISPLAY is set to $DISPLAY"
echo "Starting YTSage" && \
/usr/bin/python3 /app/main.py

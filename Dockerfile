FROM jlesage/baseimage-gui:ubuntu-22.04-v4

# Install required packages
RUN apt-get update && apt-get install -y \
    python3 python3-pip python3-setuptools wget net-tools yt-dlp ffmpeg \
    libxcb-cursor0 libx11-xcb1 libxcb1 libxcb-render0 libxcb-shape0 libxcb-xfixes0 \
    libxcb-keysyms1 libxcb-image0 libxcb-icccm4 libxcb-sync1 libxcb-xinerama0 \
    libxcb-randr0 libxcb-glx0 libxrender1 libxext6 libxi6 libxkbcommon0 \
    libgl1-mesa-glx libegl1-mesa

# Install Python dependencies (adjust if you have requirements.txt)
COPY requirements.txt /app/requirements.txt
RUN pip3 install --no-cache-dir -r /app/requirements.txt

# Copy your app files
COPY . /app
WORKDIR /app

# Copy start script
COPY start.sh /start.sh
RUN chmod +x /start.sh

RUN set-cont-env APP_NAME "YTSage"
RUN set-cont-env APP_VERSION "4.6.0"
RUN set-cont-env DOCKER_IMAGE_VERSION "0.2.1"

# Expose ports for noVNC and VNC
EXPOSE 5800 5900

CMD ["/start.sh"]

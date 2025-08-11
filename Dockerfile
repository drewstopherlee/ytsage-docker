FROM jlesage/baseimage-gui:ubuntu-v22.04

# Install required packages
RUN apt-get update && apt-get install -y \
    python3 python3-pip python3-setuptools wget net-tools yt-dlp

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
RUN set-cont-env DOCKER_IMAGE_VERSION "0.2.0"

# Expose ports for noVNC and VNC
EXPOSE 5800 5900

CMD ["/start.sh"]

FROM python:3.11-slim

# Install dependencies for PySide6, yt-dlp, ffmpeg, and VNC
RUN apt-get update && apt-get install -y \
    ffmpeg \
    libgl1 \
    libx11-6 \
    libxext6 \
    libxrender1 \
    libxkbcommon-x11-0 \
    x11vnc \
    xvfb \
    fluxbox \
    websockify \
    wget \
    && rm -rf /var/lib/apt/lists/*

# Install noVNC
RUN mkdir -p /opt/novnc \
    && wget -qO- https://github.com/novnc/noVNC/archive/refs/tags/v1.4.0.tar.gz | tar xz --strip-components=1 -C /opt/novnc \
    && ln -s /opt/novnc/vnc_lite.html /opt/novnc/index.html

# Set working directory
WORKDIR /app

# Copy app files
COPY . /app

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Start script
COPY start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 8080

CMD ["/start.sh"]

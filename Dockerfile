FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Install required packages
RUN apt-get update && apt-get install -y \
    python3 python3-pip python3-setuptools \
    xvfb fluxbox x11vnc wget net-tools \
    novnc websockify supervisor \
    libxkbcommon0 libxcb-cursor0 libx11-xcb1 libglu1-mesa libxrender1 libxcomposite1 libxcursor1 libxdamage1 libxfixes3 libxi6 libxtst6 libxrandr2 libxss1 libxinerama1 libxext6 libegl1-mesa libgl1-mesa-glx \
    && rm -rf /var/lib/apt/lists/*

# Install Python dependencies (adjust if you have requirements.txt)
COPY requirements.txt /app/requirements.txt
RUN pip3 install --no-cache-dir -r /app/requirements.txt

# Copy your app files
COPY . /app
WORKDIR /app

# Copy start script
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Serve noVNC at root
RUN ln -sf /usr/share/novnc/vnc.html /usr/share/novnc/index.html

# Expose ports for noVNC and VNC
EXPOSE 8080 5900

CMD ["/start.sh"]

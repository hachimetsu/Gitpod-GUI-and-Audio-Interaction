FROM gitpod/workspace-full-vnc
SHELL ["/bin/bash", "-c"]

# Install PulseAudio
USER root
RUN apt update -y && apt upgrade -y \
    && apt-get clean

RUN apt-get install -y pulseaudio \
    && apt update -y \
    && apt-get clean

# Install pavucontrol For PulseAudio
RUN apt-get install -y pavucontrol \
    && apt update -y \
    && apt-get clean


# Install Brave browser or any other browser you prefer
RUN wget -qO - https://brave-browser-apt-release.s3.brave.com/brave-core.asc | gpg --dearmor > brave-keyring.gpg \
    && install -o root -g root -m 644 brave-keyring.gpg /usr/share/keyrings/ \
    && echo "deb [signed-by=/usr/share/keyrings/brave-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main" | tee /etc/apt/sources.list.d/brave.list \
    && apt update -y \
    && apt install -y brave-browser \
    && apt-get clean

# Misc dependencies
RUN apt-get install -y \
  libasound2-dev \
  libgtk-3-dev \
  libnss3-dev \
  fonts-noto \
  fonts-noto-cjk

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y pulseaudio
    
# Configure PulseAudio
USER gitpod
RUN echo "default-server = unix:/tmp/pulseaudio.socket" > /home/gitpod/.config/pulse/client.conf
ENV PULSE_SERVER=unix:/tmp/pulseaudio.socket


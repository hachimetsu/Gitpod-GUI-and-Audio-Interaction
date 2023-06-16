FROM gitpod/workspace-full-vnc
SHELL ["/bin/bash", "-c"]

USER root
# Install Brave browser or any other browser you prefer
RUN wget -qO - https://brave-browser-apt-release.s3.brave.com/brave-core.asc | gpg --dearmor > brave-keyring.gpg \
    && install -o root -g root -m 644 brave-keyring.gpg /usr/share/keyrings/ \
    && echo "deb [signed-by=/usr/share/keyrings/brave-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main" | tee /etc/apt/sources.list.d/brave.list \
    && apt update -y \
    && apt install -y brave-browser \
    && apt-get clean

# Install pavucontrol
RUN apt-get install -y pavucontrol \
    && apt update -y \
    && apt-get clean

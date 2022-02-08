# this image is built and updated weekly
# https://github.com/cse-labs/codespaces-images

FROM ghcr.io/cse-labs/k3d:latest

# some images require specific values
ARG USERNAME=vscode

# log the docker build start / complete events
RUN echo "$(date)    docker build start" >> /home/$USERNAME/status && \
    echo "$(date)    docker build complete" >> /home/$USERNAME/status && \
    chown -R $USERNAME:$USERNAME /home/$USERNAME

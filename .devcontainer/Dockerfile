# this image is built and updated weekly
# https://github.com/cse-labs/codespaces-images

FROM ghcr.io/cse-labs/k3d:latest

# some images require specific values
ARG USERNAME=vscode

# log the docker build start event
RUN echo "$(date +'%Y-%m-%d %H:%M:%S')    docker build start" >> /home/$USERNAME/status

# install fluent-bit
RUN curl https://packages.fluentbit.io/fluentbit.key | gpg --dearmor > /usr/share/keyrings/fluentbit-keyring.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/fluentbit-keyring.gpg] https://packages.fluentbit.io/ubuntu/focal focal main" > /etc/apt/sources.list.d/fluent-bit.list && \
    apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y fluent-bit && \
    echo 'export PATH=$PATH:/opt/fluent-bit/bin' >> /home/$USERNAME/.zshrc


RUN chown -R $USERNAME:$USERNAME /home/$USERNAME

# log the docker build complete
RUN echo "$(date +'%Y-%m-%d %H:%M:%S')    docker build complete" >> /home/$USERNAME/status

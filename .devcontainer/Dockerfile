# this image is built and updated weekly
# https://github.com/retaildevcrews/codespaces-images
FROM ghcr.io/retaildevcrews/kind:latest

# some images require specific values
ARG USERNAME=vscode
ENV PATH $PATH:/home/${USERNAME}/.dapr/bin

# [Optional] Uncomment this section to install additional OS packages.
# alternatively, you can add commands to on-create.sh and/or post-create.sh
# on-create runs before the Codespaces UI appears
# post-create runs in the background after the UI appears
# RUN apt-get -y install --no-install-recommends <your-package-list-here>

# upgrade packages
# you can improve startup time by runing in post-create.sh
# RUN apt upgrade -y

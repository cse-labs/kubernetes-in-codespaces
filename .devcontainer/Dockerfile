# Note: You can use any Debian/Ubuntu base image
FROM mcr.microsoft.com/vscode/devcontainers/dotnet
# FROM mcr.microsoft.com/vscode/devcontainers/base:focal

# user args
# some base images require specific values
ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID

# copy the stup scripts to the container
COPY library-scripts/*.sh /scripts/
COPY local-scripts/*.sh /scripts/

# install selected components
# many scripts take optional parameters
# see the script header for details of each
RUN export DEBIAN_FRONTEND=noninteractive \
    && apt-get update \
    # order matters for the next 4 scripts
    # uncomment this line if you're using a base image that is not from vscode/devcontainers
    #&& /bin/bash /scripts/common-debian.sh \
    && /bin/bash /scripts/docker-in-docker-debian.sh \
    && /bin/bash /scripts/kubectl-helm-debian.sh \
    && /bin/bash /scripts/kind-k3d-debian.sh \
    # Optional components
    # uncomment any you want to install
    #&& bash /scripts/azcli-debian.sh \
    #&& bash /scripts/dotnet-debian.sh \
    #&& bash /scripts/git-lfs-debian.sh \
    #&& bash /scripts/github-debian.sh \
    #&& bash /scripts/go-debian.sh \
    #&& bash /scripts/gradle-debian.sh \
    #&& bash /scripts/java-debian.sh \
    #&& bash /scripts/maven-debian.sh \
    #&& bash /scripts/node-debian.sh \
    #&& bash /scripts/powershell-debian.sh \
    #&& bash /scripts/python-debian.sh \
    #&& bash /scripts/ruby-debian.sh \
    #&& bash /scripts/rust-debian.sh \
    #&& bash /scripts/sshd-debian.sh \
    #&& bash /scripts/terraform-debian.sh \
    # set welcome message
    && echo "👋 Welcome to Codespaces! You are on a custom image defined in your devcontainer.json file.\n" > /usr/local/etc/vscode-dev-containers/first-run-notice.txt \
    && echo "🔍 To explore VS Code to its fullest, search using the Command Palette (Cmd/Ctrl + Shift + P)\n" >> /usr/local/etc/vscode-dev-containers/first-run-notice.txt \
    && echo "run 'make all' to build a kind cluster in Codespaces\n\n" >> /usr/local/etc/vscode-dev-containers/first-run-notice.txt

# docker socket required for Docker in Docker
VOLUME [ "/var/lib/docker" ]

# Setting the ENTRYPOINT to docker-init.sh will start up the Docker Engine 
# inside the container "overrideCommand": false is set in devcontainer.json. 
# The script will also execute CMD if you need to alter startup behaviors.
ENTRYPOINT [ "/usr/local/share/docker-init.sh" ]
CMD [ "sleep", "infinity" ]

# [Optional] Uncomment this section to install additional OS packages.
# alternatively, you can add commands to on-create.sh and/or post-create.sh
# on-create runs before the Codespaces UI appears
# post-create runs in the background after the UI appears
# RUN apt-get -y install --no-install-recommends <your-package-list-here>

# upgrade packages
# you can improve startup time by runing in post-create.sh
# RUN apt upgrade -y

#!/usr/bin/env bash
#-------------------------------------------------------------------------------------------------------------
# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT License. See https://go.microsoft.com/fwlink/?linkid=2090316 for license information.
#-------------------------------------------------------------------------------------------------------------
#
# Docs: https://github.com/microsoft/vscode-dev-containers/blob/main/script-library/docs/kubectl-helm.md
# Maintainer: The VS Code and Codespaces Teams
#
# Syntax: ./kind-debian.sh [install kind] [install k3d]

set -e

INSTALL_KIND="${1:-"true"}"
INSTALL_K3D="${2:-"true"}"

if [ "$(id -u)" -ne 0 ]; then
    echo 'Script must be run as root. Use sudo, su, or add "USER root" to your Dockerfile before running this script.'
    echo "(!) $0 failed!"
    exit 1
fi

if ! type kubectl > /dev/null 2>&1; then
    echo 'You must run kubectl-helm-debian.sh first'
    echo "(!) $0 failed!"
    exit 1
fi

if [ "${INSTALL_KIND}" != "true" ] && [ "${INSTALL_K3D}" != "true" ]; then
    echo 'Invalid Parameters: You must install either Kind or K3d'
    echo "(!) $0 failed!"
    exit 1
fi

export DEBIAN_FRONTEND=noninteractive

# Install required packages
apt-get update
apt-get -y install --no-install-recommends apt-utils dialog
apt-get -y install --no-install-recommends coreutils gnupg2 ca-certificates apt-transport-https
apt-get -y install --no-install-recommends software-properties-common make build-essential
apt-get -y install --no-install-recommends git wget curl bash-completion jq gettext iputils-ping

ARCHITECTURE="$(uname -m)"
case $ARCHITECTURE in
    x86_64) ARCHITECTURE="amd64";;
    aarch64 | armv8*) ARCHITECTURE="arm64";;
    aarch32 | armv7* | armvhf*) ARCHITECTURE="arm";;
    i?86) ARCHITECTURE="386";;
    *) echo "(!) Architecture $ARCHITECTURE unsupported"; exit 1 ;;
esac

# Install Kind
if [ "${INSTALL_KIND}" == "true" ]; then
    echo "Installing Kind ..."

   KIND_VERSION=$(basename "$(curl -fsSL -o /dev/null -w "%{url_effective}" https://github.com/kubernetes-sigs/kind/releases/latest)")

    curl -Lo /usr/local/bin/kind https://kind.sigs.k8s.io/dl/${KIND_VERSION}/kind-linux-${ARCHITECTURE}
    chmod 0755 /usr/local/bin/kind
fi

# install k3d
if [ "${INSTALL_K3D}" == "true" ]; then
    echo "Installing K3d ..."

    wget -q -O - https://raw.githubusercontent.com/rancher/k3d/main/install.sh | bash
fi

echo "Installing K9s ..."

mkdir -p /home/${USERNAME}/.k9s
K9S_VERSION=$(basename "$(curl -fsSL -o /dev/null -w "%{url_effective}" https://github.com/derailed/k9s/releases/latest)")
curl -Lo ./k9s.tar.gz https://github.com/derailed/k9s/releases/download/${K9S_VERSION}/k9s_Linux_x86_64.tar.gz
mkdir k9s
tar xvzf k9s.tar.gz -C ./k9s
chmod 755 ./k9s/k9s
mv ./k9s/k9s /usr/local/bin/k9s
rm -rf k9s.tar.gz k9s

echo "Installing FluxCD ..."

FLUX_VERSION=$(basename "$(curl -fsSL -o /dev/null -w "%{url_effective}" https://github.com/fluxcd/flux/releases/latest)")

curl -Lo /usr/local/bin/fluxctl https://github.com/fluxcd/flux/releases/download/${FLUX_VERSION}/fluxctl_linux_${ARCHITECTURE}
chmod 755 /usr/local/bin/fluxctl

echo "Installing Istio ..."

# remove istio directories
rm -rf istio*
rm -rf /usr/local/istio

# install istio
curl -L https://istio.io/downloadIstio | sh -
mv istio* istio

chmod -R 755 istio
cp istio/tools/_istioctl /home/$USERNAME/.oh-my-zsh/completions
cp istio/tools/istioctl.bash /etc/bash_completion.d

chown -R ${USERNAME}:${USERNAME} /home/${USERNAME}

mv istio /usr/local

echo "Installing httpie ..."

apt-get -y install --no-install-recommends python3 python3-pip

pip3 install --upgrade pip setuptools httpie

echo "Installing jmespath ..."

JP_VERSION=$(basename "$(curl -fsSL -o /dev/null -w "%{url_effective}" https://github.com/jmespath/jp/releases/latest)")
curl -Lo /usr/local/bin/jp https://github.com/jmespath/jp/releases/download/${JP_VERSION}/jp-linux-${ARCHITECTURE}
chmod +x /usr/local/bin/jp

echo "Creating directories ..."
mkdir -p /grafana
chown -R 472:472 /grafana
mkdir -p /prometheus
chown -R 65534:65534 /prometheus

echo "Updating config ..."
echo -e 'export PATH=$PATH:$HOME/.dotnet/tools:/usr/local/istio/bin' | tee -a /etc/zsh/zshrc >> /etc/bash.bashrc

echo -e "alias k='kubectl'" | tee -a /etc/zsh/zshrc >> /etc/bash.bashrc
echo -e "alias kga='kubectl get all'" | tee -a /etc/zsh/zshrc >> /etc/bash.bashrc
echo -e "alias kgaa='kubectl get all --all-namespaces'" | tee -a /etc/zsh/zshrc >> /etc/bash.bashrc
echo -e "alias kaf='kubectl apply -f'" | tee -a /etc/zsh/zshrc >> /etc/bash.bashrc
echo -e "alias kdelf='kubectl delete -f'" | tee -a /etc/zsh/zshrc >> /etc/bash.bashrc
echo -e "alias kl='kubectl logs'" | tee -a /etc/zsh/zshrc >> /etc/bash.bashrc
echo -e "alias kccc='kubectl config current-context'" | tee -a /etc/zsh/zshrc >> /etc/bash.bashrc
echo -e "alias kcgc='kubectl config get-contexts'" | tee -a /etc/zsh/zshrc >> /etc/bash.bashrc
echo -e "alias kj='kubectl exec -it jumpbox -- bash -l'" | tee -a /etc/zsh/zshrc >> /etc/bash.bashrc
echo -e "alias kje='kubectl exec -it jumpbox -- '" | tee -a /etc/zsh/zshrc >> /etc/bash.bashrc
echo -e "alias ipconfig='ip -4 a show eth0 | grep inet | sed \"s/inet//g\" | sed \"s/ //g\" | cut -d / -f 1'" | tee -a /etc/zsh/zshrc >> /etc/bash.bashrc
echo -e "export FLUX_FORWARD_NAMESPACE=flux-cd" | tee -a /etc/zsh/zshrc >> /etc/bash.bashrc
echo -e "export GO111MODULE=on" | tee -a /etc/zsh/zshrc >> /etc/bash.bashrc
echo -e 'export PIP=$(ipconfig | tail -n 1)' | tee -a /etc/zsh/zshrc >> /etc/bash.bashrc

# bash only
echo -e "complete -F __start_kubectl k" >> /etc/bash.bashrc

if ! type docker > /dev/null 2>&1; then
    echo -e '\n(*) Warning: The docker command was not found.\n\nYou can use one of the following scripts to install it:\n\nhttps://github.com/microsoft/vscode-dev-containers/blob/main/script-library/docs/docker-in-docker.md\n\nor\n\nhttps://github.com/microsoft/vscode-dev-containers/blob/main/script-library/docs/docker.md'
fi

echo -e "\n${0} Done!"

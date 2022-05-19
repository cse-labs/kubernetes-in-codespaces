#!/bin/bash

# this runs as part of pre-build

echo "on-create start"
echo "$(date +'%Y-%m-%d %H:%M:%S')    on-create start" >> "$HOME/status"

# clone repos
git clone https://github.com/cse-labs/imdb-app /workspaces/imdb-app
git clone https://github.com/microsoft/webvalidate /workspaces/webvalidate

export REPO_BASE=$PWD
export PATH="$PATH:$HOME/bin"

mkdir -p "$HOME/.ssh"
mkdir -p "$HOME/bin"

{
    # add cli to path
    echo "export PATH=\$PATH:\$HOME/bin"

    echo "export REPO_BASE=$REPO_BASE"
    echo "compinit"
} >> "$HOME/.zshrc"

# restore the repos
dotnet restore /workspaces/webvalidate/src/webvalidate.sln
dotnet restore /workspaces/imdb-app/src/imdb.csproj

# make sure everything is up to date
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get autoremove -y
sudo apt-get clean -y

# create local registry
docker network create k3d
k3d registry create registry.localhost --port 5500
docker network connect k3d k3d-registry.localhost

# update the base docker images
docker pull mcr.microsoft.com/dotnet/aspnet:6.0-alpine
docker pull mcr.microsoft.com/dotnet/sdk:6.0
docker pull ghcr.io/cse-labs/webv-red:latest

echo "dowloading kic CLI"
# download cli
mkdir -p "$HOME/bin"
cd "$HOME/bin" || exit

tag=$(curl -s https://api.github.com/repos/retaildevcrews/akdc/releases/latest | grep "tag_name" | awk '{print substr($2, 2, length($2)-3)}')
wget -O kic.tar.gz https://github.com/retaildevcrews/akdc/releases/download/$tag/kic-$tag-linux-amd64.tar.gz
tar -zxvf kic.tar.gz
rm -f kic.tar.gz

cd "$OLDPWD" || exit

echo "generating kic completion"
kic completion zsh > "$HOME/.oh-my-zsh/completions/_kic"

echo "creating k3d cluster"
kic cluster rebuild

echo "on-create complete"
echo "$(date +'%Y-%m-%d %H:%M:%S')    on-create complete" >> "$HOME/status"

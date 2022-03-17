#!/bin/bash

# this runs as part of pre-build

echo "on-create start"
echo "$(date +'%Y-%m-%d %H:%M:%S')    on-create start" >> "$HOME/status"

# clone repos
git clone https://github.com/cse-labs/imdb-app /workspaces/imdb-app
git clone https://github.com/microsoft/webvalidate /workspaces/webvalidate
### todo - remove akdc usage once kic image is available
git clone https://github.com/retaildevcrews/akdc /workspaces/akdc

export REPO_BASE=$PWD
export PATH="$PATH:$REPO_BASE/bin"

mkdir -p "$HOME/.ssh"
mkdir -p "$HOME/.oh-my-zsh/completions"

# add cli completions
cp ../akdc/src/_* "$HOME/.oh-my-zsh/completions"
cp -r ../akdc/bin /workspaces/kubernetes-in-codespaces

{
    # add cli to path
    echo "export PATH=\$PATH:$REPO_BASE/bin"

    # create aliases
    echo "alias mk='cd $REPO_BASE/../akdc/src/kic && make build; cd \$OLDPWD'"
    echo "alias kic='akdc local'"
    echo "alias flt='akdc fleet'"

    echo "export REPO_BASE=$PWD"
    echo "export KIC_PATH=/workspaces/kubernetes-in-codespaces/bin"
    echo "export KIC_NAME=akdc"
    echo "compinit"
} >> "$HOME/.zshrc"

# restore the repos
dotnet restore /workspaces/webvalidate/src/webvalidate.sln
dotnet restore /workspaces/imdb-app/src/imdb.csproj

# copy grafana.db to /grafana
sudo cp .devcontainer/grafana.db /grafana
sudo chown -R 472:0 /grafana

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
docker pull mcr.microsoft.com/dotnet/sdk:5.0-alpine
docker pull mcr.microsoft.com/dotnet/aspnet:5.0-alpine
docker pull mcr.microsoft.com/dotnet/sdk:5.0
docker pull mcr.microsoft.com/dotnet/aspnet:6.0-alpine
docker pull mcr.microsoft.com/dotnet/sdk:6.0
docker pull ghcr.io/cse-labs/webv-red:latest
docker pull ghcr.io/cse-labs/webv-red:beta

echo "creating k3d cluster"
akdc local cluster rebuild

echo "on-create complete"
echo "$(date +'%Y-%m-%d %H:%M:%S')    on-create complete" >> "$HOME/status"

#!/bin/bash

echo "post-create start" >> ~/status

# this runs in background after UI is available

# (optional) upgrade packages
#sudo apt-get update
#sudo apt-get upgrade -y
#sudo apt-get autoremove -y
#sudo apt-get clean -y

# create local registry
docker network create k3d
k3d registry create registry.localhost --port 5500
docker network connect k3d k3d-registry.localhost

# update the base docker images
docker pull mcr.microsoft.com/dotnet/sdk:5.0-alpine
docker pull mcr.microsoft.com/dotnet/aspnet:5.0-alpine
docker pull mcr.microsoft.com/dotnet/sdk:5.0

echo "post-create complete" >> ~/status

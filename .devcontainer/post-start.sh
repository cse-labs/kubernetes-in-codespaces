#!/bin/bash

# this runs each time the container starts

echo "$(date)    post-start start" >> ~/status

# update the base docker images
docker pull mcr.microsoft.com/dotnet/sdk:5.0-alpine
docker pull mcr.microsoft.com/dotnet/aspnet:5.0-alpine
docker pull mcr.microsoft.com/dotnet/sdk:5.0

echo "$(date)    post-start complete" >> ~/status

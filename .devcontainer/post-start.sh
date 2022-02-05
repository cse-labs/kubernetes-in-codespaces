#!/bin/bash

echo "post-start start" >> ~/status

# this runs each time the container starts

# update the repos
git pull -C /workspaces/ngsa-app
git pull -C /workspaces/webvalidate

# update the base docker images
#docker pull mcr.microsoft.com/dotnet/sdk:5.0-alpine
#docker pull mcr.microsoft.com/dotnet/aspnet:5.0-alpine
#docker pull mcr.microsoft.com/dotnet/sdk:5.0

echo "post-start complete" >> ~/status

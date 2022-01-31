#!/bin/bash

echo "post-create start" >> ~/status

# this runs in background after UI is available

# (optional) upgrade packages
#sudo apt-get update
#sudo apt-get upgrade -y
#sudo apt-get autoremove -y
#sudo apt-get clean -y

dotnet restore /workspaces/webvalidate/src/webvalidate.sln
dotnet restore /workspaces/ngsa-app/Ngsa.App.csproj

echo "post-create complete" >> ~/status

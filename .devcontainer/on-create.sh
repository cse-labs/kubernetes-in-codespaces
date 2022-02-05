#!/bin/bash

echo "on-create start" >> ~/status

# clone repos
git clone https://github.com/retaildevcrews/ngsa-app /workspaces/ngsa-app
git clone https://github.com/microsoft/webvalidate /workspaces/webvalidate

# restore the repos
dotnet restore /workspaces/webvalidate/src/webvalidate.sln
dotnet restore /workspaces/ngsa-app/Ngsa.App.csproj

# copy grafana.db to /grafana
sudo cp deploy/grafanadata/grafana.db /grafana
sudo chown -R 472:0 /grafana

# make sure everything is up to date
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get autoremove -y
sudo apt-get clean -y

echo "on-create complete" >> ~/status

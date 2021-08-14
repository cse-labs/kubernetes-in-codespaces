#!/bin/bash

echo "on-create start" >> ~/status

# run dotnet restore
dotnet restore weather/weather.csproj 

# clone repos
git clone https://github.com/retaildevcrews/ngsa-app /workspaces/ngsa-app
git clone https://github.com/microsoft/webvalidate /workspaces/webvalidate

# copy grafana.db to /grafana
sudo rm -f /grafana/grafana.db
sudo cp deploy/grafanadata/grafana.db /grafana
sudo chown -R 472:0 /grafana

# initialize dapr
dapr init

echo "on-create complete" >> ~/status

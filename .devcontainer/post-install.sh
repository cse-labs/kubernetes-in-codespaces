#!/bin/sh

# clone repos
pushd ..
git clone https://github.com/retaildevcrews/ngsa-app
git clone https://github.com/microsoft/webvalidate
popd

# copy grafana.db to /grafana
sudo mkdir -p /grafana
sudo  cp deploy/grafanadata/grafana.db /grafana
sudo  chown -R 472:472 /grafana

# install webv
dotnet tool install -g webvalidate

# install k3d
wget -q -O - https://raw.githubusercontent.com/rancher/k3d/main/install.sh | bash

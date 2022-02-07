#!/bin/bash

# this runs at Codespace creation - not part of pre-build

echo "$(date)    post-create start" >> ~/status

# update the repos
git pull -C /workspaces/ngsa-app
git pull -C /workspaces/webvalidate

echo "$(date)    post-create complete" >> ~/status

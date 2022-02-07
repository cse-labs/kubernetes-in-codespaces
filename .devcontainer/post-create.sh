#!/bin/bash

# this runs at Codespace creation - not part of pre-build

echo "$(date)    post-create start" >> ~/status

# this runs after pre-build

# update the repos
git pull -C /workspaces/ngsa-app
git pull -C /workspaces/webvalidate

echo "$(date)    post-create complete" >> ~/status

#!/bin/bash

echo "$(date)    post-create start" >> ~/status

# this runs after pre-build

# update the repos
git pull -C /workspaces/ngsa-app
git pull -C /workspaces/webvalidate

echo "$(date)    post-create complete" >> ~/status

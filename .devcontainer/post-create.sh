#!/bin/bash

echo "post-create start" >> ~/status

# this runs after pre-build

# update the repos
git pull -C /workspaces/ngsa-app
git pull -C /workspaces/webvalidate

echo "post-create complete" >> ~/status


# GitOps with Flux

> Make sure to create a branch first as you'll need to push updates for GitOps

## Setup Flux

```bash

# delete and recreate the cluster
make create

# set GitOps repo
# make sure you're not on the main branch
#   git checkout -b yourBranchName
#   git push -u origin yourBranchName
export GIT_REPO=$(git remote get-url origin)
export GIT_BRANCH=$(git branch --show-current)
export GIT_PATH=gitops

# create flux.yaml from the template using the GIT_* env vars above
rm -f deploy/flux/flux.yaml
cat deploy/flux/template | envsubst  > deploy/flux/flux.yaml

# apply flux.yaml
kubectl apply -f deploy/flux/flux.yaml

# check the pods until flux is running
kubectl get pods -n flux-cd -l app.kubernetes.io/name=flux

# check flux logs
kubectl logs -n flux-cd -l app.kubernetes.io/name=flux

# check for fluentb, monitoring/prometheus and monitoring/grafana pods
kubectl get po -A

```

> Congratulations! You just bootstrapped a kubernetes cluster with GitOps

### Deploy the apps with GitOps

- Flux watches your GitHub repo::branch for changes
- Simply push the yaml files to your GitHub branch

```bash

# copy the yaml files to gitops/apps
mkdir -p gitops/apps
cp deploy/ngsa-memory/ngsa-memory.yaml gitops/apps
cp deploy/webv/webv.yaml gitops/apps

# push to GitHub
git add gitops
git commit -m "added apps to GitOps"
git push

# force flux to sync (or wait ~ 5 min)
fluxctl sync

# check for ngsa-memory and webv pods
kubectl get pods

# validate apps
make check
make test

```

### Making Changes

To make changes, simply update the `gitops` directory and push to GitHub

# Fluent Bit Setup

Setup Fluent Bit on a dev cluster by sending everything to stdout and then to Azure Log Analytics

```bash

# start in the fluentbit directory
#   assumes you were in the app directory
cd ../fluentbit

### Create secrets if necessary
###   fluentbit won't run without these secrets
###   skip this step if already set
kubectl create secret generic log-secrets \
  --from-literal=WorkspaceId=unused \
  --from-literal=SharedKey=unused

# create the fluentbit service account
kubectl apply -f account.yaml

# apply env vars
kubectl apply -f log.yaml


# apply fluentbit config to log to stdout
kubectl apply -f stdout-config.yaml

# deploy ngsa app
kubectl apply -f ../app/in-memory.yaml

# check pods
kubectl get pods

# wait for pod to show Running
kubectl logs ngsa-memory -c app

# start fluentbit pod
kubectl apply -f fluentbit-pod.yaml

# check pods
kubectl get pods

# wait for pod to show Running
kubectl logs fluentb

# save the cluster IP
export ngsa=http://$(kubectl get service ngsa-memory -o jsonpath="{.spec.clusterIP}"):4120

# check the version and genres endpoints
http $ngsa/version
http $ngsa/api/genres

# check the logs again
kubectl logs fluentb

# delete fluentb
kubectl delete -f fluentbit-pod.yaml

# delete ngsa-memory
kubectl delete -f ../app/in-memory.yaml

# check pods
kubectl get pods

# Result - No resources found in default namespace.

```

## Test sending to Log Analytics

### Login to Azure

```bash

# login to Azure
az login

az account list -o table

# select subscription (if necesary)
az account set -s YourSubscriptionName

```

### Setup Azure Log Analytics

```bash

# set environment variables (edit if desired)
export Ngsa_Log_Loc=westus2
export Ngsa_Log_RG=akdc
export Ngsa_Log_Name=akdc

# add az cli extension
az extension add --name log-analytics

# create Log Analytics instance
az monitor log-analytics workspace create -g $Ngsa_Log_RG -n $Ngsa_Log_Name -l $Ngsa_Log_Loc

# delete log-secrets
kubectl delete secret log-secrets

# add Log Analytics secrets
kubectl create secret generic log-secrets \
  --from-literal=WorkspaceId=$(az monitor log-analytics workspace show -g $Ngsa_Log_RG -n $Ngsa_Log_Name --query customerId -o tsv) \
  --from-literal=SharedKey=$(az monitor log-analytics workspace get-shared-keys -g $Ngsa_Log_RG -n $Ngsa_Log_Name --query primarySharedKey -o tsv)

# display the secrets (base 64 encoded)
kubectl get secret log-secrets -o jsonpath='{.data}'

```

### Deploy to Kubernetes

```bash

# create app pod
kubectl apply -f ../app/in-memory.yaml

# apply the config and create fluentb pod
kubectl apply -f loga-config.yaml

# start fluentbit pod
kubectl apply -f fluentbit-pod.yaml

# check pods
kubectl get pods

# check fluentb logs
kubectl logs fluentb

# run baseline test
kubectl apply -f ../webv/baseline-memory.yaml

# check pods
kubectl get pods

# delete baseline test after status: Completed
kubectl delete -f ../webv/baseline-memory.yaml

# check pods
kubectl get pods

# check fluentb logs
kubectl logs fluentb

# looking for a line like:
#   [2020/11/16 21:54:19] [ info] [output:azure:azure.*]

# check Log Analytics for your data
# this can take 10-15 minutes :(

# delete the app
kubectl delete -f fluentbit-pod.yaml
kubectl delete -f ../app/in-memory.yaml

# check pods
kubectl get pods

# Result - No resources found in default namespace.

```

#!/bin/bash

set -ex

# Build the image with tag
docker build . -t gcr.io/infra-cicd-279015/secret-pull-app

# Push the image to the google cloud docker registry
docker push gcr.io/infra-cicd-279015/secret-pull-app

# Applying K8S manifest 
kubectl apply -f ./manifests/secret-pull-app.yaml

# Workload identity activation
./wi.sh

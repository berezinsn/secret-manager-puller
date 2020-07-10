#!/bin/bash

set -e

# GCP project id
PROJECT_ID=infra-cicd-279015

# Google service account name
GSA_NAME=secret-manager

# Kubernetes service account name
KSA_NAME=secret-manager

# K8S namespace
K8S_NS=default

gcloud config set project ${PROJECT_ID}

# Create accouts
gcloud iam service-accounts create ${GSA_NAME} 2>/dev/null | echo "Google service account ${GSA_NAME} already exists"
kubectl create namespace ${K8S_NS} 2>/dev/null || echo "Kubernetes namespace ${K8S_NS} already exists"
kubectl create serviceaccount --namespace ${K8S_NS} ${KSA_NAME} 2>/dev/null || echo "Kubernetes service account ${KSA_NAME} already exists"

# Binding the KSA and GSA
gcloud iam service-accounts add-iam-policy-binding \
  --role roles/iam.workloadIdentityUser \
  --member "serviceAccount:${PROJECT_ID}.svc.id.goog[${K8S_NS}/${KSA_NAME}]" \
  ${GSA_NAME}@${PROJECT_ID}.iam.gserviceaccount.com

# KSA annotation
kubectl annotate serviceaccount \
  --namespace ${K8S_NS} \
  ${KSA_NAME} \
  iam.gke.io/gcp-service-account=${GSA_NAME}@${PROJECT_ID}.iam.gserviceaccount.com \
  2>/dev/null | echo "Annotation is already exists"






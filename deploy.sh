#!/bin/bash

# Set variables
PROJECT_ID=devoteam-khawar
REGION=us-central1
CLUSTER_NAME=devoteam-khawar-gke
TF_DIR="./terraform"

# Function to check if command succeeded
check_command() {
  if [ $? -ne 0 ]; then
    echo "Error executing: $1"
    exit 1
  fi
}

# Initialize Terraform
cd $TF_DIR
terraform init
check_command "terraform init"

# Apply Terraform plan
terraform apply -var="project_id=$PROJECT_ID" -var="region=$REGION" -auto-approve
check_command "terraform apply"

# Get credentials for the Kubernetes cluster
gcloud container clusters get-credentials $CLUSTER_NAME --region $REGION --project $PROJECT_ID
check_command "gcloud container clusters get-credentials"

# Apply Kubernetes configurations (assumes k8s-config.yaml exists in the same directory as the script)
kubectl apply -f ./release/kubernetes-manifests.yaml
check_command "kubectl apply -f ./release/kubernetes-manifests.yaml"

echo "Deployment completed successfully!"

# GCP Kubernetes Cluster Setup

## Project Details
- **Project ID:** devoteam-khawar
- **Region:** us-central1

## Steps

### Step 1: Set Up GCP Project and Environment

1. **Set your project and region environment variables**:
    ```sh
    export PROJECT_ID=devoteam-khawar
    export REGION=us-central1
    ```

2. **Set the GCP project**:
    ```sh
    gcloud config set project $PROJECT_ID
    ```

3. **Enable the required APIs**:
    ```sh
    gcloud services enable container.googleapis.com compute.googleapis.com
    ```

### Step 2: Create a VPC Network

1. **Create a custom VPC**:
```sh
gcloud compute networks create k8s-vpc --subnet-mode=custom
```

2. **Create subnets for nodes, pods, and services**:

```sh
gcloud compute networks subnets create k8s-nodes-subnet --network=k8s-vpc --range=10.0.0.0/16 --region=$REGION

gcloud compute networks subnets create k8s-pods-subnet --network=k8s-vpc --range=10.1.0.0/16 --region=$REGION

gcloud compute networks subnets create k8s-services-subnet --network=k8s-vpc --range=10.2.0.0/16 --region=$REGION
```

### Step 3: Create the Kubernetes Cluster

1. **Create the Kubernetes cluster with specific IP ranges**:
```sh
gcloud container clusters create k8s-cluster \
    --network=k8s-vpc \
    --subnetwork=k8s-nodes-subnet \
    --cluster-ipv4-cidr=10.1.0.0/16 \
    --services-ipv4-cidr=10.2.0.0/16 \
    --enable-ip-alias \
    --region=$REGION
```

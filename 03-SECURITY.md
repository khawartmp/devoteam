### Step 4: Set Up Role-Based Access Control (RBAC)

1. **Create custom IAM roles for least-privileged access**:
    - Define roles for different types of users (e.g., cluster-admin, devops, viewer).
    - Create custom roles using YAML files and apply them using the `gcloud` command.

2. **Example YAML for a custom role (save as `role.yaml`)**:
    ```yaml
    title: "K8sClusterViewer"
    description: "Read-only access to Kubernetes cluster"
    stage: "GA"
    includedPermissions:
    - container.clusters.get
    - container.clusters.list
    - container.pods.get
    - container.pods.list
    - container.services.get
    - container.services.list
    ```

    Apply the role:
    ```sh
    gcloud iam roles create k8sClusterViewer --project=$PROJECT_ID --file=role.yaml
    ```

3. **Assign IAM roles to users**:
    ```sh
    gcloud projects add-iam-policy-binding $PROJECT_ID \
        --member=user:USER_EMAIL \
        --role=projects/$PROJECT_ID/roles/k8sClusterViewer
    ```

### Step 5: Enable Collaboration

1. **Create a shared Google Cloud Source Repository** for storing Kubernetes configuration files and manifests.
    ```sh
    gcloud source repos create k8s-config-repo
    ```

2. **Grant access to the repository to different engineers**:
    ```sh
    gcloud source repos add-iam-policy-binding k8s-config-repo \
        --member=user:USER_EMAIL \
        --role=roles/source.reader

    gcloud source repos add-iam-policy-binding k8s-config-repo \
        --member=user:USER_EMAIL \
        --role=roles/source.writer
    ```

3. **Use `kubectl` to manage Kubernetes configurations**. Engineers can collaborate on configuration files in the repository and apply them to the cluster without side effects.

### Step 6: Implement Network Policies

1. **Create network policies** to restrict traffic between pods as necessary.
    ```yaml
    apiVersion: networking.k8s.io/v1
    kind: NetworkPolicy
    metadata:
      name: allow-specific-traffic
      namespace: default
    spec:
      podSelector:
        matchLabels:
          role: frontend
      policyTypes:
      - Ingress
      - Egress
      ingress:
      - from:
        - podSelector:
            matchLabels:
              role: backend
    ```

2. **Apply the network policy**:
    ```sh
    kubectl apply -f network-policy.yaml
    ```

## Summary

1. **Networking**: VPC with subnets for nodes, pods, and services.
2. **Security**: Custom IAM roles with least-privileged access.
3. **Ops**: Shared repository and IAM roles for collaboration.

These steps will ensure that your Kubernetes cluster is set up with the specified networking ranges, secure access, and collaborative capabilities.

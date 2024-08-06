### Step 4: Set Up Role-Based Access Control (RBAC)

1. **Create custom IAM roles for least-privileged access**:
- Define roles for different types of users (e.g., cluster-admin, devops, viewer).
- Create custom roles using YAML files and apply them using the `gcloud` command.

Apply the role:
```sh
gcloud iam roles create k8sClusterViewer --project=$PROJECT_ID --file=./release/role.yaml
```

3. **Assign IAM roles to users**:
```sh
gcloud projects add-iam-policy-binding $PROJECT_ID --member=user:USER_EMAIL --role=projects/$PROJECT_ID/roles/k8sClusterViewer
```

### Step 5: Enable Collaboration

1. **Create a shared Google Cloud Source Repository** for storing Kubernetes configuration files and manifests.
```sh
gcloud source repos create k8s-config-repo
```

2. **Grant access to the repository to different engineers**:
```sh
gcloud source repos add-iam-policy-binding k8s-config-repo --member=user:USER_EMAIL --role=roles/source.reader

gcloud source repos add-iam-policy-binding k8s-config-repo --member=user:USER_EMAIL --role=roles/source.writer
```


### Step 6: Implement Network Policies

2. **Apply the network policy**:
```sh
kubectl apply -f ./release/network-policy.yaml
```

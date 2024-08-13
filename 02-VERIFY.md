gcloud container clusters get-credentials $(terraform output -raw kubernetes_cluster_name) --region $(terraform output -raw region)

gcloud container clusters get-credentials devoteam-khawar-gke --zone us-central1

kubectl get nodes -o wide

kubectl get pods  -o wide -A

kubectl get svc  -o wide -A
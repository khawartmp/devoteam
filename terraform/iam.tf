resource "google_project_iam_custom_role" "k8s_cluster_viewer" {
  role_id     = "k8sClusterViewer"
  title       = "K8sClusterViewer"
  description = "Read-only access to Kubernetes cluster"
  permissions = [
    "container.clusters.get",
    "container.clusters.list",
    "container.pods.get",
    "container.pods.list",
    "container.services.get",
    "container.services.list",
  ]
  project = var.project_id
}

resource "google_project_iam_binding" "bind_k8s_cluster_viewer" {
  project = var.project_id
  role    = "projects/${var.project_id}/roles/k8sClusterViewer"

  members = [
    "user:USER_EMAIL"
  ]
}

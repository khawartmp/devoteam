output "k8s_cluster_name" {
  value = google_container_cluster.k8s_cluster.name
}

output "k8s_cluster_endpoint" {
  value = google_container_cluster.k8s_cluster.endpoint
}

output "k8s_cluster_master_version" {
  value = google_container_cluster.k8s_cluster.master_version
}

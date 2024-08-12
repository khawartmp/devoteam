output "vpc_network_name" {
  value = google_compute_network.gke_vpc_network.name
}

output "gke_cluster_name" {
  value = google_container_cluster.gke_cluster.name
}

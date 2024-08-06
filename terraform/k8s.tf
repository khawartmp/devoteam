resource "google_container_cluster" "k8s_cluster" {
  name     = "k8s-cluster"
  location = var.region

  network    = google_compute_network.k8s_vpc.self_link
  subnetwork = google_compute_subnetwork.k8s_nodes_subnet.self_link

  ip_allocation_policy {
    cluster_ipv4_cidr_block  = "10.1.0.0/16"
    services_ipv4_cidr_block = "10.2.0.0/16"
  }

  node_config {
    machine_type = "e2-medium"
  }

  initial_node_count = 1
}

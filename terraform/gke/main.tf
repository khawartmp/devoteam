resource "google_container_cluster" "gke_cluster" {
  name     = "gke-cluster"
  location = var.region

  network    = var.vpc_network_name
  subnetwork = var.subnet_name

  ip_allocation_policy {
    use_ip_aliases             = true
    cluster_secondary_range_name  = "gke-pods-range"
    services_secondary_range_name = "gke-services-range"
  }

  node_config {
    machine_type = "e2-medium"
    tags         = ["gke-node"]

    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
      "https://www.googleapis.com/auth/devstorage.read_write",
      "https://www.googleapis.com/auth/service.management.readonly",
      "https://www.googleapis.com/auth/servicecontrol",
    ]
  }

  node_pool {
    name       = "default-pool"
    node_count = 1

    node_config {
      preemptible  = false
      machine_type = "e2-medium"

      disk_size_gb = 100
      oauth_scopes = [
        "https://www.googleapis.com/auth/logging.write",
        "https://www.googleapis.com/auth/monitoring",
      ]
    }

    management {
      auto_repair  = true
      auto_upgrade = true
    }
  }
}

output "gke_cluster_name" {
  value = google_container_cluster.gke_cluster.name
}

resource "google_compute_network" "gke_vpc_network" {
  name                    = "gke-vpc-network"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "gke_subnet" {
  name          = "gke-subnet"
  ip_cidr_range = "10.0.0.0/16"  # IP range for the nodes
  region        = var.region
  network       = google_compute_network.gke_vpc_network.id

  secondary_ip_range {
    range_name    = "gke-pods-range"
    ip_cidr_range = "10.1.0.0/16"  # Secondary range for Pods
  }

  secondary_ip_range {
    range_name    = "gke-services-range"
    ip_cidr_range = "10.2.0.0/16"  # Secondary range for Services
  }
}

resource "google_compute_firewall" "gke_firewall" {
  name    = "gke-firewall"
  network = google_compute_network.gke_vpc_network.name

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["22", "6443"]  # Allow SSH and Kubernetes API server
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["gke-node"]
}

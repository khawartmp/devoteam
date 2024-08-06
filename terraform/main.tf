provider "google" {
  project = var.project_id
  region  = var.region
}

resource "google_compute_network" "k8s_vpc" {
  name                    = "k8s-vpc"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "k8s_nodes_subnet" {
  name          = "k8s-nodes-subnet"
  ip_cidr_range = "10.0.0.0/16"
  region        = var.region
  network       = google_compute_network.k8s_vpc.name
}

resource "google_compute_subnetwork" "k8s_pods_subnet" {
  name          = "k8s-pods-subnet"
  ip_cidr_range = "10.1.0.0/16"
  region        = var.region
  network       = google_compute_network.k8s_vpc.name
}

resource "google_compute_subnetwork" "k8s_services_subnet" {
  name          = "k8s-services-subnet"
  ip_cidr_range = "10.2.0.0/16"
  region        = var.region
  network       = google_compute_network.k8s_vpc.name
}

# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

variable "project_id" {
  description = "project id"
}

variable "region" {
  description = "region"
}

provider "google" {
  project = var.project_id
  region  = var.region
}

# VPC
resource "google_compute_network" "vpc" {
  name                    = "${var.project_id}-vpc"
  auto_create_subnetworks = "false"
}

# Subnet
# resource "google_compute_subnetwork" "subnet" {
#   name          = "${var.project_id}-subnet"
#   region        = var.region
#   network       = google_compute_network.vpc.name
#   ip_cidr_range = "10.10.0.0/24"
# }

resource "google_compute_subnetwork" "subnet" {
  name = "${var.project_id}-subnetwork"

  ip_cidr_range = "10.0.0.0/16"
  region        = "us-central1"

  # stack_type       = "IPV4_IPV6"
  # ipv6_access_type = "INTERNAL" # Change to "EXTERNAL" if creating an external loadbalancer

  network = google_compute_network.vpc.name
  secondary_ip_range {
    range_name    = "services-range"
    ip_cidr_range = "10.2.0.0/16"
  }

  secondary_ip_range {
    range_name    = "pod-ranges"
    ip_cidr_range = "10.1.0.0/16"
  }
}

# # Subnet for nodes
# resource "google_compute_subnetwork" "subnet_nodes" {
#   name          = "${var.project_id}-subnet-nodes"
#   region        = var.region
#   network       = google_compute_network.vpc.name
#   ip_cidr_range = "10.0.0.0/16"
# }

# resource "google_compute_subnetwork" "subnet_pods" {
#   name          = "${var.project_id}-subnet-pods"
#   region        = var.region
#   network       = google_compute_network.vpc.name
#   ip_cidr_range = "10.1.0.0/16"
# }

# resource "google_compute_subnetwork" "subnet_services" {
#   name          = "${var.project_id}-subnet-services"
#   region        = var.region
#   network       = google_compute_network.vpc.name
#   ip_cidr_range = "10.2.0.0/16"
# }

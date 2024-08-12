variable "region" {
  description = "The region where the GKE cluster will be created."
  type        = string
}

variable "vpc_network_name" {
  description = "The name of the VPC network to use for the GKE cluster."
  type        = string
}

variable "subnet_name" {
  description = "The name of the subnetwork to use for the GKE cluster."
  type        = string
}

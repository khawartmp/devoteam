provider "google" {
  project = "devoteam-khawar"  # Your specific project ID
  region  = var.region
  zone    = var.zone
}

module "vpc" {
  source  = "./vpc"
  region  = var.region
}

module "gke" {
  source          = "./gke"
  region          = var.region
  vpc_network_name = module.vpc.network_name
  subnet_name      = module.vpc.subnet_name
}

variable "project_id" {
  description = "The GCP project ID."
  type        = string
  default     = "devoteam-khawar"  # Set your specific project ID here
}

variable "region" {
  description = "The region where resources will be created."
  type        = string
  default     = "us-central1"
}

variable "zone" {
  description = "The zone where resources will be created."
  type        = string
  default     = "us-central1-a"
}

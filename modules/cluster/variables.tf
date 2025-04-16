variable "project_id" {
  description = "project id"
}

variable "region" {
  description = "region"
}

variable "vpc_name" {
  description = "vpc name"
}

variable "subnet_name" {
  description = "subnet name"
}

variable "gke_version_prefix" {
  description = "Prefix for GKE version"
  type        = string
  default     = "1.32."
}
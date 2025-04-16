variable "gke_username" {
  default     = ""
  description = "gke username"
}

variable "gke_password" {
  default     = ""
  description = "gke password"
}

variable "gke_num_nodes" {
  default     = 2
  description = "number of gke nodes"
}

variable "project_id" {
  description = "project id"
}

variable "region" {
  description = "region"
  default = "us-central1"
}

variable "repo_name" {
  description = "repo_name"
  default = "name"
}
variable "repo_description" {
  description = "repo_description"
  default = "desc"
}

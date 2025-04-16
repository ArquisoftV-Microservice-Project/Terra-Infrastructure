variable "project_id" {
  description = "project id"
  type = string
}

variable "region" {
  description = "region"
  default = "us-central1"
  type = string
}

variable "repo_name" {
  description = "repo_name"
  default = "name"
  type = string
}

variable "repo_description" {
  description = "repo_description"
  default = "desc"
  type = string
}

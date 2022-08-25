variable "aws_region" {
  type = string
}

variable "assume_role_name" {
  type = string
}

variable "cluster_name" {
  type = string
}

variable "namespace" {
  type = string
}

variable "cluster_ca" {
  type = string
}

variable "cluster_auth" {
  type = string
}

variable "grafana_version" {
  type    = string
  default = "latest"
}

variable "account_id" {
  type = string
}

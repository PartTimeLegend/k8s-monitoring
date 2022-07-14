variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "assume_role_arn" {
  type = string
}

variable "cluster_name" {
  type = string
}

variable "namespace" {
  type    = string
  default = "monitoring"
}

variable "grafana_version" {
  type    = string
  default = "latest"
}
variable "aws_region" {
  type = string
}

variable "assume_role_arn" {
  type = string
}

variable "cluster_name" {
  type = string
}

variable "cluster_ca" {
  type = string
}

variable "cluster_auth" {
  type = string
}

variable "namespace" {
  type = string
}

variable "replicas" {
  type    = number
  default = 3
}

variable "loki_version" {
  type    = string
  default = "2.6.1"
}

variable "account_id" {
  type = string
}

variable "loki_docker_image" {
  type    = string
  default = "grafana/loki"
}

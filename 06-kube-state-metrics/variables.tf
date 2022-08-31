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

variable "timeout" {
  type = number
}

variable "repository" {
  type = string
}

variable "name" {
  type = string
}

variable "chart" {
  type = string
}

variable "chart_version" {
  type = string
}

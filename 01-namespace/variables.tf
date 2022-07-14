variable "namespace" {
  type    = string
  default = "monitoring"
}

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

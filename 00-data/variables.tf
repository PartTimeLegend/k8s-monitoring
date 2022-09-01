variable "namespace" {
  type = list(string)
}

variable "aws_region" {
  type = string
}

variable "assume_role_name" {
  type = string
}

variable "cluster_name" {
  type = string
}

variable "account_id" {
  type = string
}

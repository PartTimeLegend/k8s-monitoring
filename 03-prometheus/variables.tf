variable "scrape" {
  type    = string
  default = "true"
}

variable "service_port" {
  type    = number
  default = 8080
}

variable "ingress_class" {
  type    = string
  default = "nginx"
}

variable "domain" {
  description = "Base domain for the subdomain e.g. example.com for prometheus.example.com"
  type        = string
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

variable "namespace" {
  type = string
}

variable "cluster_ca" {
  type = string
}

variable "cluster_auth" {
  type = string
}

variable "account_id" {
  type = string
}

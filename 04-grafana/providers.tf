provider "aws" {
  region = var.aws_region
  assume_role {
    role_arn = "arn:aws:iam::${var.account_id}:role/${var.assume_role_name}"
  }
}

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
  required_version = ">= 1.0"
  #backend "s3" {
  #}
}

provider "kubernetes" {
  host                   = var.cluster_name
  cluster_ca_certificate = base64decode(var.cluster_ca)
  token                  = var.cluster_auth
}

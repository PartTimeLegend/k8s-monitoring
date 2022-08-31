provider "aws" {
  region = var.aws_region
  assume_role {
    role_arn = var.assume_role_arn
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

provider "helm" {
  kubernetes {
    host                   = var.cluster_name
    cluster_ca_certificate = base64decode(var.cluster_ca)
    token                  = var.cluster_auth
  }
}

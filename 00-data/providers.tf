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

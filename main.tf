module "namespace" {
  source          = "./01-namespace"
  namespace       = var.namespace
  aws_region      = var.aws_region
  assume_role_arn = var.assume_role_arn
  cluster_name    = var.cluster_name
}

module "prometheus" {
  source          = "./02-prometheus"
  namespace       = var.namespace
  aws_region      = var.aws_region
  assume_role_arn = var.assume_role_arn
  cluster_name    = var.cluster_name
  domain          = var.domain
}

module "grafana" {
  source          = "./03-grafana"
  namespace       = var.namespace
  aws_region      = var.aws_region
  assume_role_arn = var.assume_role_arn
  cluster_name    = var.cluster_name
}

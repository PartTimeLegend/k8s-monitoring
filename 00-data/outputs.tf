output "cluster_auth" {
  value = data.aws_eks_cluster_auth.auth.token
}

output "cluster_name" {
  value = data.aws_eks_cluster.cluster.endpoint
}

output "namespace" {
  value = var.namespace
}

output "aws_region" {
  value = var.aws_region
}

output "assume_role_arn" {
  value = var.assume_role_arn
}

output "cluster_ca" {
  value = data.aws_eks_cluster.cluster.certificate_authority[0].data
}

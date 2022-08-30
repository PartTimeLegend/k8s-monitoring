resource "kubernetes_service_account" "this" {
  automount_service_account_token = true
  metadata {
    annotations = {
      "eks.amazonaws.com/role-arn" = aws_iam_role.role.arn
    }
    labels = {
      "app.kubernetes.io/name" = "loki"
    }
    name      = "loki"
    namespace = var.namespace
  }
}

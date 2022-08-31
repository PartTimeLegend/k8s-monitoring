resource "helm_release" "release" {
  name       = var.name
  chart      = var.chart
  repository = var.repository
  version    = var.chart_version
  namespace  = var.namespace
  timeout    = var.timeout
}

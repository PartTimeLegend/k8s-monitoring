resource "kubernetes_namespace" "namespace" {
  count = length(var.namespace)
  metadata {
    name = var.namespace[count.index]
  }
}

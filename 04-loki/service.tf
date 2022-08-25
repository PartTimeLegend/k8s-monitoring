resource "kubernetes_service" "this" {
  metadata {
    labels = {
      "app.kubernetes.io/name" = "loki"
    }
    name      = "loki"
    namespace = var.namespace
  }
  spec {
    port {
      name        = "grpc-api"
      port        = 81
      protocol    = "TCP"
      target_port = "grpc"
    }
    port {
      name        = "http-api"
      port        = 80
      protocol    = "TCP"
      target_port = "http"
    }
    selector = {
      "app.kubernetes.io/instance" = "default"
      "app.kubernetes.io/name"     = "loki"
    }
    type = "ClusterIP"
  }
  depends_on = [
    kubernetes_service_account.this
  ]
}

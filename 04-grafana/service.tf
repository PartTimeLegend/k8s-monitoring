resource "kubernetes_manifest" "service_monitoring_grafana" {
  manifest = {
    "apiVersion" = "v1"
    "kind"       = "Service"
    "metadata" = {
      "annotations" = {
        "prometheus.io/port"   = "3000"
        "prometheus.io/scrape" = "true"
      }
      "name"      = "grafana"
      "namespace" = var.namespace
    }
    "spec" = {
      "ports" = [
        {
          "nodePort"   = 32000
          "port"       = 3000
          "targetPort" = 3000
        },
      ]
      "selector" = {
        "app" = "grafana"
      }
      "type" = "NodePort"
    }
  }
}

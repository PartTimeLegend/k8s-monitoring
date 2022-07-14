resource "kubernetes_manifest" "service_monitoring_prometheus_service" {
  manifest = {
    "apiVersion" = "v1"
    "kind"       = "Service"
    "metadata" = {
      "annotations" = {
        "prometheus.io/port"   = "9090"
        "prometheus.io/scrape" = var.scrape
      }
      "name"      = "prometheus-service"
      "namespace" = data.kubernetes_namespace.namespace.metadata[0].name
    }
    "spec" = {
      "ports" = [
        {
          "nodePort"   = 30000
          "port"       = 8080
          "targetPort" = 9090
        },
      ]
      "selector" = {
        "app" = "prometheus-server"
      }
      "type" = "NodePort"
    }
  }
  depends_on = [
    kubernetes_manifest.deployment_monitoring_prometheus_deployment
  ]
}

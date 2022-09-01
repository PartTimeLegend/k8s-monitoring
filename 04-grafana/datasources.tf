resource "kubernetes_manifest" "configmap_monitoring_grafana_datasources" {
  manifest = {
    "apiVersion" = "v1"
    "data" = {
      "prometheus.yaml" = <<-EOT
      {
          "apiVersion": 1,
          "datasources": [
              {
                 "access":"proxy",
                  "editable": true,
                  "name": "prometheus",
                  "orgId": 1,
                  "type": "prometheus",
                  "url": "http://prometheus-service.monitoring.svc:8080",
                  "version": 1
              }
          ]
      }
      EOT
    }
    "kind" = "ConfigMap"
    "metadata" = {
      "name"      = "grafana-datasources"
      "namespace" = var.namespace
    }
  }
}

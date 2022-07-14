resource "kubernetes_manifest" "ingress_monitoring_prometheus_ui" {
  manifest = {
    "apiVersion" = "extensions/v1beta1"
    "kind"       = "Ingress"
    "metadata" = {
      "annotations" = {
        "kubernetes.io/ingress.class" = var.ingress_class
      }
      "name"      = "prometheus-ui"
      "namespace" = data.kubernetes_namespace.namespace.metadata[0].name
    }
    "spec" = {
      "rules" = [
        {
          "host" = "prometheus.${var.domain}"
          "http" = {
            "paths" = [
              {
                "backend" = {
                  "serviceName" = "prometheus-service"
                  "servicePort" = 8080
                }
              },
            ]
          }
        },
      ]
    }
  }
  depends_on = [
    kubernetes_manifest.service_monitoring_prometheus_service
  ]
}

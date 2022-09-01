resource "kubernetes_manifest" "deployment_monitoring_grafana" {
  manifest = {
    "apiVersion" = "apps/v1"
    "kind"       = "Deployment"
    "metadata" = {
      "name"      = "grafana"
      "namespace" = var.namespace
    }
    "spec" = {
      "replicas" = 1
      "selector" = {
        "matchLabels" = {
          "app" = "grafana"
        }
      }
      "template" = {
        "metadata" = {
          "labels" = {
            "app" = "grafana"
          }
          "name" = "grafana"
        }
        "spec" = {
          "containers" = [
            {
              "image" = "grafana/grafana:${var.grafana_version}"
              "name"  = "grafana"
              "ports" = [
                {
                  "containerPort" = 3000
                  "name"          = "grafana"
                },
              ]
              "resources" = {
                "limits" = {
                  "cpu"    = "1000m"
                  "memory" = "1Gi"
                }
                "requests" = {
                  "cpu"    = "500m"
                  "memory" = "500M"
                }
              }
              "volumeMounts" = [
                {
                  "mountPath" = "/var/lib/grafana"
                  "name"      = "grafana-storage"
                },
                {
                  "mountPath" = "/etc/grafana/provisioning/datasources"
                  "name"      = "grafana-datasources"
                  "readOnly"  = false
                },
              ]
            },
          ]
          "volumes" = [
            {
              "emptyDir" = {}
              "name"     = "grafana-storage"
            },
            {
              "configMap" = {
                "defaultMode" = 420
                "name"        = "grafana-datasources"
              }
              "name" = "grafana-datasources"
            },
          ]
        }
      }
    }
  }
}

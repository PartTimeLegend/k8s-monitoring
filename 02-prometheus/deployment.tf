resource "kubernetes_manifest" "deployment_monitoring_prometheus_deployment" {
  manifest = {
    "apiVersion" = "apps/v1"
    "kind"       = "Deployment"
    "metadata" = {
      "labels" = {
        "app" = "prometheus-server"
      }
      "name"      = "prometheus-deployment"
      "namespace" = data.kubernetes_namespace.namespace.metadata[0].name
    }
    "spec" = {
      "replicas" = 1
      "selector" = {
        "matchLabels" = {
          "app" = "prometheus-server"
        }
      }
      "template" = {
        "metadata" = {
          "labels" = {
            "app" = "prometheus-server"
          }
        }
        "spec" = {
          "containers" = [
            {
              "args" = [
                "--storage.tsdb.retention.time=12h",
                "--config.file=/etc/prometheus/prometheus.yml",
                "--storage.tsdb.path=/prometheus/",
              ]
              "image" = "prom/prometheus"
              "name"  = "prometheus"
              "ports" = [
                {
                  "containerPort" = 9090
                },
              ]
              "resources" = {
                "limits" = {
                  "cpu"    = 1
                  "memory" = "1Gi"
                }
                "requests" = {
                  "cpu"    = "500m"
                  "memory" = "500M"
                }
              }
              "volumeMounts" = [
                {
                  "mountPath" = "/etc/prometheus/"
                  "name"      = "prometheus-config-volume"
                },
                {
                  "mountPath" = "/prometheus/"
                  "name"      = "prometheus-storage-volume"
                },
              ]
            },
          ]
          "volumes" = [
            {
              "configMap" = {
                "defaultMode" = 420
                "name"        = "prometheus-server-conf"
              }
              "name" = "prometheus-config-volume"
            },
            {
              "emptyDir" = {}
              "name"     = "prometheus-storage-volume"
            },
          ]
        }
      }
    }
  }
  depends_on = [
    kubernetes_manifest.configmap_monitoring_prometheus_server_conf
  ]
}

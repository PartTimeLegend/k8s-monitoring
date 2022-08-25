resource "kubernetes_deployment" "loki" {
  metadata {
    annotations = {
      "field.cattle.io/description" = "Loki"
    }
    labels = {
      "app.kubernetes.io/instance" = "default"
      "app.kubernetes.io/name"     = "loki"
      "app.kubernetes.io/version"  = "v${var.loki_version}"
    }
    name      = "loki"
    namespace = var.namespace
  }
  spec {
    replicas = var.replicas
    selector {
      match_labels = {
        "app.kubernetes.io/instance" = "default"
        "app.kubernetes.io/name"     = "loki"
      }
    }
    template {
      metadata {
        labels = {
          "app.kubernetes.io/instance" = "default"
          "app.kubernetes.io/name"     = "loki"
          "app.kubernetes.io/version"  = "v${var.loki_version}"
        }
      }
      spec {
        affinity {
          node_affinity {
            required_during_scheduling_ignored_during_execution {
              node_selector_term {
                match_expressions {
                  key      = "kubernetes.io/os"
                  operator = "In"
                  values   = ["linux"]
                }
                match_expressions {
                  key      = "kubernetes.io/arch"
                  operator = "In"
                  values   = ["amd64"]
                }
              }
            }
          }
          pod_anti_affinity {
            preferred_during_scheduling_ignored_during_execution {
              weight = 100
              pod_affinity_term {
                label_selector {
                  match_expressions {
                    key      = "app.kubernetes.io/name"
                    operator = "In"
                    values   = ["loki"]
                  }
                }
                topology_key = "kubernetes.io/hostname"
              }
            }
          }
        }
        automount_service_account_token = true
        container {
          args = [
            "-log.level=$(LOKI_LOG_LEVEL)",
            "-ring.store=$(LOKI_RING_STORE)",
            "-server.grpc-listen-port=$(LOKI_GRPC_LISTEN_PORT)",
            "-server.http-listen-port=$(LOKI_HTTP_LISTEN_PORT)",
            "-config.file=/etc/loki/loki.yaml"
          ]
          env {
            name  = "LOKI_LOG_LEVEL"
            value = "info"
          }
          env {
            name  = "LOKI_RING_STORE"
            value = "inmemory"
          }
          env {
            name  = "LOKI_GRPC_LISTEN_PORT"
            value = "9095"
          }
          env {
            name  = "LOKI_HTTP_LISTEN_PORT"
            value = "8080"
          }
          image             = "${var.loki_docker_image}:${var.loki_version}"
          image_pull_policy = "IfNotPresent"
          name              = "loki"
          port {
            container_port = 8080
            name           = "http"
            protocol       = "TCP"
          }
          port {
            container_port = 9095
            name           = "grpc"
            protocol       = "TCP"
          }
          readiness_probe {
            http_get {
              path = "/ready"
              port = "http"
            }
            initial_delay_seconds = 30
          }
          resources {
            limits = {
              cpu    = null
              memory = null
            }
            requests = {
              cpu    = "1000m"
              memory = "256Mi"
            }
          }
          security_context {
            read_only_root_filesystem = true
          }
          termination_message_path = "/dev/termination-log"
          volume_mount {
            mount_path = "/etc/loki"
            name       = "config"
            read_only  = true
          }
        }
        dns_policy     = "ClusterFirst"
        host_network   = false
        restart_policy = "Always"
        security_context {
          fs_group        = 10001
          run_as_group    = 10001
          run_as_non_root = true
          run_as_user     = 10001
        }
        service_account_name             = kubernetes_service_account.this.metadata[0].name
        termination_grace_period_seconds = 30
        volume {
          name = "config"
          config_map {
            name = kubernetes_config_map.this.metadata[0].name
          }
        }
      }
    }
  }
  depends_on = [
    aws_s3_bucket.chunks,
    aws_iam_role_policy_attachment.attachment
  ]
}

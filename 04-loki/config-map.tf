resource "kubernetes_config_map" "this" {
  data = {
    "loki.yaml" = yamlencode({
      auth_enabled = false
      ingester = {
        lifecycler = {
          address = "0.0.0.0"
          ring = {
            kvstore = {
              store = "inmemory"
            }
            replication_factor = 1
          }
          final_sleep = "0s"
        }
        chunk_idle_period   = "5m"
        chunk_retain_period = "30s"
      }
      schema_config = {
        configs = [
          {
            from         = "2020-01-01"
            store        = "aws"
            object_store = "s3"
            schema       = "v11"
            index = {
              prefix = "${var.cluster_name}-loki-index-"
              period = "${24 * 7}h"
            }
          }
        ]
      }
      storage_config = {
        aws = {
          s3 = "s3://${var.aws_region}/${aws_s3_bucket.chunks.bucket}"
          dynamodb = {
            dynamodb_url = "dynamodb://${var.aws_region}"
          }
        }
      }
      table_manager = {
        retention_deletes_enabled = true
        retention_period          = "${24 * 21}h"
        index_tables_provisioning = {
          enable_ondemand_throughput_mode : true
          enable_inactive_throughput_on_demand_mode : true
        }
      }
      limits_config = {
        enforce_metric_name        = false
        reject_old_samples         = true
        reject_old_samples_max_age = "168h"
      }
    })
  }
  metadata {
    labels = {
      "app.kubernetes.io/name" = "loki"
    }
    name      = "loki"
    namespace = var.namespace
  }
}

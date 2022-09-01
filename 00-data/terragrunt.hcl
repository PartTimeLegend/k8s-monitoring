inputs = {
  namespace        = ["monitoring", "ingress","observability"]
  aws_region       = "us-east-1"
  assume_role_name = "terrafrom-deploy-role"
  cluster_name     = "abtest"
  account_id       = "1234567890"
}

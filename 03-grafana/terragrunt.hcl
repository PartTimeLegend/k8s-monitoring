dependency "data" {
  config_path = "../00-data"

  mock_outputs = {
    namespace = "monitoring"
    aws_region = "us-east-1"
    assume_role_arn = "no-secrets-here"
    cluster_name = "foo"
    cluster_ca = "abc"
    cluster_auth = "def"
    account_id = "123456789"
    assume_role_name = "bar"
    oidc_issuer = "foobar"
  }
}

dependency "namespace" {
  config_path = "../01-namespace"

  mock_outputs = {
    namespace = "monitoring"
  }
}

dependency "prometheus" {
  config_path = "../02-prometheus"

  mock_outputs = {
    namespace = "monitoring"
  }
}

inputs = {
  namespace = dependency.namespace.outputs.namespace
  aws_region = dependency.data.outputs.aws_region
  cluster_name = dependency.data.outputs.cluster_name
  cluster_ca = dependency.data.outputs.cluster_ca
  cluster_auth = dependency.data.outputs.cluster_auth
  account_id = dependency.data.outputs.account_id
  assume_role_name = dependency.data.outputs.assume_role_name
}

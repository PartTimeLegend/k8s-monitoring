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
    oidc_issuer = "foobar"
  }
}

inputs = {
    namespace = dependency.data.outputs.namespace
    aws_region = dependency.data.outputs.aws_region
    assume_role_arn = dependency.data.outputs.assume_role_arn
    cluster_name = dependency.data.outputs.cluster_name
    cluster_ca = dependency.data.outputs.cluster_ca
    cluster_auth = dependency.data.outputs.cluster_auth
}

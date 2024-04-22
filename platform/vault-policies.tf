resource "vault_policy" "lambda" {
  name = "${var.prefix}-lambda-policy"

  policy = <<EOT
path "${vault_kv_secret_v2.secret.path}" {
  capabilities = [ "read" ]
}
EOT
}
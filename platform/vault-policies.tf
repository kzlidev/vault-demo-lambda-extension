resource "vault_policy" "lambda" {
  name = "${var.prefix}-lambda-policy"

  policy = <<EOT
path "${vault_kv_secret_v2.secret.path}" {
  capabilities = [ "read" ]
}
path "${vault_mount.transit.path}/*" {
   capabilities = [ "create", "read", "update", "delete", "list" ]
}
EOT
}

# path "demo-kvv2/data/demo-secret" {
#   capabilities = [ "read" ]
# }
# path "demo-transit/*" {
#    capabilities = [ "create", "read", "update", "delete", "list" ]
# }

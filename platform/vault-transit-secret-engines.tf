resource "vault_transit_secret_backend_key" "key" {
  backend = vault_mount.transit.path
  name    = "${var.prefix}-key"
}
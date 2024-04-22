resource "vault_mount" "kvv2" {
  path        = "${var.prefix}-kvv2"
  type        = "kv"
  options     = { version = "2" }
  description = "KV Version 2 secret engine mount"
}

resource "vault_mount" "transit" {
  path                      = "${var.prefix}-transit"
  type                      = "transit"
  description               = "Transit engine"
  default_lease_ttl_seconds = 3600
  max_lease_ttl_seconds     = 86400
}

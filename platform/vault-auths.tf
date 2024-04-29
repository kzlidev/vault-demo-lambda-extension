# Enable AWS Auth Backend
resource "vault_auth_backend" "aws" {
  type = "aws"
}

# Enable AWS Auth Backend
resource "vault_auth_backend" "aws" {
  type = "aws"
}

resource "vault_aws_auth_backend_sts_role" "role" {
  backend    = vault_auth_backend.aws.path
  account_id = var.target_account_id
  sts_role   = "arn:aws:iam::${var.target_account_id}:role/${var.sts_account_name}"
}
resource "vault_aws_auth_backend_role" "aws_auth_role" {
  depends_on               = [vault_aws_auth_backend_sts_role.role, aws_iam_role.vault_auth_role]
  backend                  = vault_auth_backend.aws.path
  role                     = aws_iam_role.lambda_role.name
  bound_iam_principal_arns = [aws_iam_role.lambda_role.arn]
  auth_type                = "iam"

  token_policies = [vault_policy.lambda.name]

  # This does introduce a limitation; the ARN you reference for bound_iam_principal_arn must be in the form
  # you've given it, because the setting instructs Vault not to resolve ARNs into unique IDs and so it can only
  # pattern match between the ARNs given to it. Vault still properly validates the identity of the role and it's
  # still a secure option, just more restrictive in how you can configure it.
  resolve_aws_unique_ids = false
}

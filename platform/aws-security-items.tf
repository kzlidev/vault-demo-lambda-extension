data "aws_iam_policy_document" "lambda_assume_role_policy"{
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "lambda_role" {
  name = "${var.prefix}-lambda-role"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role_policy.json
}

resource "aws_iam_policy" "vault_auth_method" {
  name        = "aws-iampolicy-for-vault-authmethod"
  path        = "/"
  description = "Policy for Vault Auth Method"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "ec2:DescribeInstances",
          "iam:GetInstanceProfile",
          "iam:GetUser",
          "iam:GetRole",
          "iam:ListRoles"
        ],
        "Resource" : "*"
      }
    ]
  })
}

data "aws_iam_policy_document" "vault_auth_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${var.vault_account_id}:root"]
    }

    condition {
      test     = "StringEquals"
      variable = "aws:PrincipalArn"
      values   = [
        "arn:aws:iam::${var.vault_account_id}:role/HCP-Vault-ddc93669-0d1e-47b5-9307-72e6759790cb-VaultNode"
      ]
    }
  }
}

resource "aws_iam_role" "vault_auth_role" {
  name                = var.sts_account_name
  assume_role_policy  = data.aws_iam_policy_document.vault_auth_assume_role_policy.json
  managed_policy_arns = [
    aws_iam_policy.vault_auth_method.arn
  ]
}
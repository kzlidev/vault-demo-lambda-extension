data "archive_file" "python_lambda_package" {
  type        = "zip"
  source_file = "${path.module}/../src/lambda_function.py"
  output_path = "src.zip"
}

resource "aws_lambda_function" "test_lambda" {
  filename         = "src.zip"
  function_name    = "${var.prefix}-vault-demo"
  role             = aws_iam_role.lambda_role.arn
  handler          = var.handler
  source_code_hash = data.archive_file.python_lambda_package.output_base64sha256
  runtime          = var.python_runtime
  architectures    = ["x86_64"]
  # Check releases here: https://github.com/hashicorp/vault-lambda-extension/releases
  layers           = ["arn:aws:lambda:${var.region}:634166935893:layer:vault-lambda-extension:18"]

  environment {
    variables = {
      VAULT_ADDR          = var.vault_addr
      VAULT_NAMESPACE     = var.vault_namespace
      VAULT_AUTH_PROVIDER = "aws"
      VAULT_AUTH_ROLE     = aws_iam_role.lambda_role.name
      VAULT_SECRET_PATH   = vault_kv_secret_v2.secret.path
      VAULT_SECRET_FILE   = "/tmp/vault/secret.json"
    }
  }
}
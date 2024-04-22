# Vault Lambda Extension Demo

**This demo will only work if your Vault is publicly accessible.** 

1. Export your `VAULT_TOKEN` as an environment variable.
```
export VAULT_TOKEN="<VAULT_TOKEN>"
```

2. To deploy, perform a Terraform run in the `platform` directory
```
cd platform
terraform apply --auto-approve 
```

Add the following variables for Terraform:

| Variable          | Description                                            |
|-------------------|--------------------------------------------------------|
| target_account_id | The account to deploy the Lambda function into         |
| vault_addr        | Public URL of your Vault cluster                       |
| vault_account_id  | AWS Account ID where your Vault cluster is deployed in |
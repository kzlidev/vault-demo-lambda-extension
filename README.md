# Vault Lambda Extension Demo

**This demo will only work if your Vault is publicly accessible.** 

1. Export your `VAULT_TOKEN` as an environment variable.
```
export VAULT_TOKEN="<VAULT_TOKEN>"
```

2. Install HVAC Python dependency as Lambda Layer in the **root directory**
```
pip3 install hvac -t ./platform/tmp/layers/hvac/python
```

3. To deploy, perform a Terraform run in the `platform` directory

```
# For HashiCorp Employees only
doormat login -f && eval $(doormat aws export --role $(doormat aws list | grep -m 1 role))

cd platform
terraform init
terraform apply --auto-approve 
```

# Vault Lambda Extension write to Disk
![Lambda extension write to disk](./img/disk.png)

# Vault Lambda Extension as Local Proxy
![Lambda extension as proxy](./img/local-proxy.png)
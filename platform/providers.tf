provider "aws" {
  default_tags {
    tags = {
      owner     = "kz.li@hashicorp.com"
      se-region = "Singapore"
      purpose   = "demo"
      terraform = true
    }
  }
  region = var.region
}

provider "vault" {
  address   = var.vault_addr
  namespace = var.vault_namespace
}
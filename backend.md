# backend.tf
```terraform
terraform {
  backend "azurerm" {
    storage_account_name = "terraformaitabe"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
    access_key           = "xxx"
  }
}

```

```bash
terraform init
terraform state
terraform plan
```
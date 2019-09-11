https://azurecitadel.com/automation/terraform/lab5/

# Provider.tf
```terraform
provider "azurerm" {
  subscription_id = "2d31be49-d959-4415-bb65-8aec2c90ba62"
  client_id       = "b8928160-69bf-4483-a2cc-b726e1e65d87"
  client_secret   = "93b1423d-26a9-4ee7-a4f6-29e32d4c05e8"
  tenant_id       = "72f988bf-86f1-41af-91ab-2d7cd012db47"
}
```

# Environment variables
```bash
export ARM_SUBSCRIPTION_ID="2d31be49-d959-4415-bb65-8aec2c90ba62"
export ARM_CLIENT_ID="b8928160-69bf-4483-a2cc-b726e1e65d87"
export ARM_CLIENT_SECRET="93b1423d-26a9-4ee7-a4f6-29e32d4c05e8"
export ARM_TENANT_ID="72f988bf-86f1-41af-91ab-2d7cd012db47"
```

# Aliases
```terraform
provider "azurerm" {
  subscription_id = "2d31be49-d999-4415-bb65-8aec2c90ba62"
  client_id       = "cf34389a-839e-42a9-8201-9a5bed151767"
  client_secret   = "923ea4d9-829a-4477-9650-7a11c4a680f3"
  tenant_id       = "72f988bf-8691-41af-91ab-2d7cd011db47"
}

provider "azurerm" {
  alias           = "azurerm.devops"
  subscription_id = "1234be49-d999-4415-bb65-8aec2c90ba62"
  client_id       = "1234389a-839e-42a9-8201-9a5bed151767"
  client_secret   = "1234a4d9-829a-4477-9650-7a11c4a680f3"
  tenant_id       = "72f988bf-8691-41af-91ab-2d7cd011db47"
}

resource "azurerm_resource_group" "devopsrg" {
  provider = "azurerm.devops"

  # ...
}
```
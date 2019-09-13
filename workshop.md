# 1 Create Ressources!
- az account show
- az account set -s ...
- terraform init
- terraform plan
- terraform apply
- git init
- gitignore file
- git add/commit...

# 2 Make it random
- storage account should contain random string part to make it unique
  - random part must not be checked in
  - must not be a variable
  - hint: random string
  - bonus combine with variable and make sure it is not longer than 23 chars
  - "terraform$(myvariable)..."

```terraform
resource "random_string" "random" {
  length  = 8
  special = false
  upper   = false
  lower   = true
}

resource "azurerm_storage_account" "labstorage" {
  name                     = "testaitterrafor${random_string.random.result}"
  resource_group_name      = "${azurerm_resource_group.lab1.name}"
  account_tier             = "Standard"
  account_replication_type = "LRS"
  location                 = "${azurerm_resource_group.lab1.location}"
  tags = {
    orderedby = "${var.tags["customer"]}"
  }
}

Bonus:
  name =   "${substr("sa${var.tags["source"]}${random_string.rnd.result}", 0, 24)}".
```

# 3 Add App Service + Application Insights
- application insights resource
- app service


# 4 Meta
```terraform
resource "azurerm_application_insights" "appInsights" {
  count = "${var.google_vpc_cidr != "" ? 1 : 0}"
  name                = "aiterraform"
  application_type    = "web"
  location            = "${azurerm_resource_group.lab1.location}"
  resource_group_name = "${azurerm_resource_group.lab1.name}"
}
```

- create 3 app services!
- create one app service in each of these regions!
    - westeurope
    - francesouth
    - northeurope
- bonus: create three app services in each of these regions!
- add application insights integration to all app services


# Backend+Provider
- create storage account (without terraform...)
- create backend.tf
- create provider

# External Data
- create storage account (or use state account) in another resource group (not within this terraform project!)
- write connection string to storage account into app service settings


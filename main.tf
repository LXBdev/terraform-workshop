resource "azurerm_resource_group" "lab1" {
  name     = "terraform-ait-lab"
  location = "westeurope"
  tags = {
    customer = "AIT"
  }
}

resource "azurerm_storage_account" "labstorage" {
    name    = "testaitterraformlab"
    resource_group_name = "${azurerm_resource_group.lab1.name}"
    account_tier = "Standard"
    account_replication_type = "LRS"
    location = "${azurerm_resource_group.lab1.location}"
}
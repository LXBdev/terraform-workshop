resource "azurerm_resource_group" "lab1" {
  name     = "terraform-ait-lab"
  location = "${var.loc}"
  tags = "${var.tags}"
}

resource "random_string" "random" {
  length = 8
  special = false
  upper = false
  lower = true
}


resource "azurerm_storage_account" "labstorage" {
    name    = "testaitterrafor${random_string.random.result}"
    resource_group_name = "${azurerm_resource_group.lab1.name}"
    account_tier = "Standard"
    account_replication_type = "LRS"
    location = "${azurerm_resource_group.lab1.location}"
    tags = {
        orderedby = "${var.tags["customer"]}"
    }
}
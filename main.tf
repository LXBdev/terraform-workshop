resource "azurerm_resource_group" "lab1" {
  name     = "terraform-ait-lab"
  location = "${var.loc}"
  tags     = "${var.tags}"
}

resource "azurerm_storage_account" "labstorage" {
  name                     = "testaitterraformlab"
  resource_group_name      = "${azurerm_resource_group.lab1.name}"
  account_tier             = "Standard"
  account_replication_type = "LRS"
  location                 = "${azurerm_resource_group.lab1.location}"
  tags = {
    orderedby = "${var.tags["customer"]}"
  }
}

resource "azurerm_application_insights" "appInsights" {
  name = "aiterraform"
  application_type = "web"
  location                 = "${azurerm_resource_group.lab1.location}"
  resource_group_name      = "${azurerm_resource_group.lab1.name}"
}


resource "azurerm_app_service_plan" "webapp-plan" {
  location            = "${azurerm_resource_group.lab1.location}"
  name                = "webapp-plan"
  resource_group_name = "${azurerm_resource_group.lab1.name}"
  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service" "webapp" {
  name                = "ait-terraform-lab-alex"
  resource_group_name = "${azurerm_resource_group.lab1.name}"
  location            = "${azurerm_resource_group.lab1.location}"
  app_service_plan_id = "${azurerm_app_service_plan.webapp-plan.id}"
}
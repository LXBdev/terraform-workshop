resource "azurerm_resource_group" "lab1" {
  name     = "terraform-ait-lab"
  location = "${var.loc}"
  tags     = "${var.tags}"
}

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

output "saKey" {
  value = "${azurerm_storage_account.labstorage.primary_connection_string}"
}

locals {
  webappsPerLocation = 3
}


resource "azurerm_application_insights" "appInsights" {
  name                = "aiterraform"
  application_type    = "web"
  location            = "${azurerm_resource_group.lab1.location}"
  resource_group_name = "${azurerm_resource_group.lab1.name}"
}


resource "azurerm_app_service_plan" "webapp-plan" {
  name                = "webapp-plan-${element(var.webapplocs, count.index)}"
  count               = "${length(var.webapplocs)}"
  location            = "${element(var.webapplocs, count.index)}"
  resource_group_name = "${azurerm_resource_group.lab1.name}"
  kind                = "Linux"
  reserved            = true
  sku {
    tier = "Free"
    size = "F1"
  }
}

resource "azurerm_app_service" "webapp" {
  name                = "${format("ait-terraform-lab-alex-%s-%02d", element(var.webapplocs, count.index), count.index)}"
  count               = "${length(var.webapplocs) * local.webappsPerLocation}"
  resource_group_name = "${azurerm_resource_group.lab1.name}"
  location            = "${element(azurerm_app_service_plan.webapp-plan.*.location, count.index)}"
  app_service_plan_id = "${element(azurerm_app_service_plan.webapp-plan.*.id, count.index)}"
  app_settings = {
    "APPINSIGHTS_INSTRUMENTATIONKEY" = "${azurerm_application_insights.appInsights.instrumentation_key}"
  }
}

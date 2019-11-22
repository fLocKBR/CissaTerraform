resource "azurerm_resource_group" "api" {
  name     = "cissa-api-resourcegroup"
  location = "Central US"
}

resource "azurerm_app_service_plan" "api" {
  name                = "cissa-api-appserviceplan"
  location            = "${azurerm_resource_group.api.location}"
  resource_group_name = "${azurerm_resource_group.api.name}"

  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service" "api" {
  name                = "cissa-api-blob"
  location            = "${azurerm_resource_group.api.location}"
  resource_group_name = "${azurerm_resource_group.api.name}"
  app_service_plan_id = "${azurerm_app_service_plan.api.id}"

  site_config {
    dotnet_framework_version = "v4.0"
    scm_type                 = "LocalGit"
  }

  app_settings = {
    "SOME_KEY" = "some-value"
  }
}
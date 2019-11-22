resource "azurerm_resource_group" "prod" {
  name     = "cissa-prod-resourcegroup"
  location = "Central US"
}

resource "azurerm_app_service_plan" "prod" {
  name                = "cissa-prod-appserviceplan"
  location            = "${azurerm_resource_group.prod.location}"
  resource_group_name = "${azurerm_resource_group.prod.name}"

  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service" "prod" {
  name                = "cissa-prod"
  location            = "${azurerm_resource_group.prod.location}"
  resource_group_name = "${azurerm_resource_group.prod.name}"
  app_service_plan_id = "${azurerm_app_service_plan.prod.id}"

  site_config {
    dotnet_framework_version = "v4.0"
    scm_type                 = "LocalGit"
  }

  app_settings = {
    "SOME_KEY" = "some-value"
  }
}
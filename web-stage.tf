resource "azurerm_resource_group" "stage" {
  name     = "cissa-stage-resourcegroup"
  location = "Central US"
}

resource "azurerm_app_service_plan" "stage" {
  name                = "cissa-stage-appserviceplan"
  location            = "${azurerm_resource_group.stage.location}"
  resource_group_name = "${azurerm_resource_group.stage.name}"

  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service" "stage" {
  name                = "cissa-stage"
  location            = "${azurerm_resource_group.stage.location}"
  resource_group_name = "${azurerm_resource_group.stage.name}"
  app_service_plan_id = "${azurerm_app_service_plan.stage.id}"

  site_config {
    dotnet_framework_version = "v4.0"
    scm_type                 = "LocalGit"
  }

  app_settings = {
    "SOME_KEY" = "some-value"
  }
}
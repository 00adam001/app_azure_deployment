terraform {
  backend "azurerm" {
    # Configuring Azure as the backend for storing Terraform state.
    resource_group_name  = "TerraformHW3"
    storage_account_name = "terraformhw3storage"
    container_name       = "tfstate"
    key                  = "dev.terraform.tfstate"
  }
}


# Create the resource group
resource "azurerm_resource_group" "rg" {
  name     = "TformHW3"
  location = "West Europe"
}

# Create the Linux App Service Plan
resource "azurerm_app_service_plan" "appserviceplan" {
  name                = "webapp-plan"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

# Create the web app, pass in the App Service Plan ID
resource "azurerm_app_service" "webapp" {
  name                  = "webapp-service"
  location              = azurerm_resource_group.rg.location
  resource_group_name   = azurerm_resource_group.rg.name
  service_plan_id       = azurerm_service_plan.appserviceplan.id
  https_only            = true
  site_config {
    python_version = "3.8"
  }

  app_settings = {
    "FLASK_APP" = "HW3my-app.py"
    "WEBSITE_RUN_FROM_PACKAGE" = "https://github.com/00adam001/assignment_3/archive/refs/heads/main.zip"
  }
}

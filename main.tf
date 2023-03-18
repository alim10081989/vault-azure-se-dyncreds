provider "vault" {
  address            = "http://${var.vault_address}"
  add_address_to_env = true
  token              = var.vault_token
}

resource "random_pet" "rg_name" {
  prefix = var.resource_group_name_prefix
}

resource "azurerm_resource_group" "azure_vault_rg" {
  location = var.resource_group_location
  name     = random_pet.rg_name.id
}

resource "vault_azure_secret_backend" "azure" {
  use_microsoft_graph_api = true
  subscription_id         = var.subscription_id
  tenant_id               = var.tenant_id
  client_id               = var.client_id
  client_secret           = var.client_secret
  path                    = "${var.name}-path"
}

resource "vault_azure_secret_backend_role" "admin" {
  backend = vault_azure_secret_backend.azure.path
  role    = "demo-app"
  ttl     = 300
  max_ttl = 600

  azure_roles {
    role_name = "Contributor"
    scope     = "/subscriptions/${var.subscription_id}"
  }
}

output "backend" {
  value = vault_azure_secret_backend.azure.id
}

output "role" {
  value = vault_azure_secret_backend_role.admin.id
}
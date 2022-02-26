provider "vault" {
  address            = "http://${var.vault_address}"
  add_address_to_env = true
  token              = var.vault_token
}

resource "azurerm_resource_group" "azure_vault_rg" {
  name     = var.resource_group_name
  location = var.location
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
  role    = "edu-app"
  ttl     = 300
  max_ttl = 600

  azure_roles {
    role_name = "Contributor"
    scope     = "/subscriptions/${var.subscription_id}/resourceGroups/${azurerm_resource_group.azure_vault_rg.name}"
  }
}

output "backend" {
  value = vault_azure_secret_backend.azure.id
}

output "role" {
  value = vault_azure_secret_backend_role.admin.id
}
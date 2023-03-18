variable "name" { default = "dyn-azure-creds-vault-admin" }
variable "tenant_id" { default = "" }
variable "subscription_id" { default = "" }
variable "client_id" { default = "" }
variable "client_secret" { default = "" }
variable "vault_address" { default = "0.0.0.0:8200" }
variable "vault_token" { default = "" }
variable "resource_group_location" { default = "East US" }
variable "resource_group_name_prefix" {
  default     = "rg"
  description = "Prefix of the resource group name that's combined with a random ID so name is unique in your Azure subscription."
}
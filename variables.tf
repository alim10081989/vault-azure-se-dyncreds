variable "name" { default = "dynamic-azure-creds-vault-admin" }
variable "tenant_id" { default = "" }
variable "subscription_id" { default = "" }
variable "client_id" { default = "" }
variable "client_secret" { default = "" }
variable "vault_address" { default = "0.0.0.0:8200" }
variable "vault_token" { default = "" }
variable "resource_group_name" { default = "azure-vault-se-rg" }
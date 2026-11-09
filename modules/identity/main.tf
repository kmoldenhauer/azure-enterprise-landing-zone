# Retrieve client configuration from current Azure subscription
data "azurerm_client_config" "current" {}

# Generate a random 4-character suffix because Key Vault names MUST be globally unique
resource "random_string" "kv_suffix" {
  length  = 4
  special = false
  upper   = false
}

# -----------------------------------------------------------------------------
# AZURE KEY VAULT
# -----------------------------------------------------------------------------
resource "azurerm_key_vault" "vault" {
  name                        = "kv-${var.project_name}-${var.environment}-${random_string.kv_suffix.result}"
  location                    = var.location
  resource_group_name         = var.resource_group_name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false
  sku_name                    = "standard"

  # Grant full secrets management permissions to the user/identity running Terraform
  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    secret_permissions = [
      "Get",
      "List",
      "Set",
      "Delete",
      "Purge",
      "Recover"
    ]
  }

  tags = var.tags
}
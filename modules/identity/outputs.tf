output "key_vault_id" {
  value       = azurerm_key_vault.vault.id
  description = "The Resource ID of Azure Key Vault."
}

output "key_vault_name" {
  value       = azurerm_key_vault.vault.name
  description = "The globally unique name of Azure Key Vault."
}

output "key_vault_uri" {
  value       = azurerm_key_vault.vault.vault_uri
  description = "The URI of Azure Key Vault for application access."
}
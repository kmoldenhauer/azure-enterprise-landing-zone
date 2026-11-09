output "hub_resource_group_name" {
  value       = azurerm_resource_group.hub.name
  description = "The name of the Hub Resource Group."
}

output "spoke_resource_group_name" {
  value       = azurerm_resource_group.spoke.name
  description = "The name of the Spoke Resource Group."
}
output "hub_vnet_id" {
  value       = azurerm_virtual_network.hub.id
  description = "The Resource ID of the Hub VNet."
}

output "spoke_vnet_id" {
  value       = azurerm_virtual_network.spoke.id
  description = "The Resource ID of the Spoke VNet."
}

output "workload_subnet_id" {
  value       = azurerm_subnet.workload.id
  description = "The Resource ID of the Workload Subnet."
}

output "workload_nsg_id" {
  value       = azurerm_network_security_group.workload.id
  description = "The Resource ID of the Workload Network Security Group."
}
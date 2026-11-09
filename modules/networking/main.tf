# -----------------------------------------------------------------------------
# HUB VIRTUAL NETWORK & SUBNET
# -----------------------------------------------------------------------------
resource "azurerm_virtual_network" "hub" {
  name                = "vnet-hub"
  location            = var.location
  resource_group_name = var.hub_rg_name
  address_space       = [var.hub_vnet_cidr]
  tags                = var.tags
}

# Azure Firewall requires the EXACT name "AzureFirewallSubnet"
resource "azurerm_subnet" "firewall" {
  name                 = "AzureFirewallSubnet"
  resource_group_name  = var.hub_rg_name
  virtual_network_name = azurerm_virtual_network.hub.name
  address_prefixes     = [var.firewall_subnet_cidr]
}

# -----------------------------------------------------------------------------
# SPOKE VIRTUAL NETWORK & SUBNET
# -----------------------------------------------------------------------------
resource "azurerm_virtual_network" "spoke" {
  name                = "vnet-spoke"
  location            = var.location
  resource_group_name = var.spoke_rg_name
  address_space       = [var.spoke_vnet_cidr]
  tags                = var.tags
}

resource "azurerm_subnet" "workload" {
  name                 = "snet-workload"
  resource_group_name  = var.spoke_rg_name
  virtual_network_name = azurerm_virtual_network.spoke.name
  address_prefixes     = [var.workload_subnet_cidr]
}

# -----------------------------------------------------------------------------
# VNET PEERING (Connecting Hub and Spoke)
# -----------------------------------------------------------------------------
resource "azurerm_virtual_network_peering" "hub_to_spoke" {
  name                         = "peer-hub-to-spoke"
  resource_group_name          = var.hub_rg_name
  virtual_network_name         = azurerm_virtual_network.hub.name
  remote_virtual_network_id    = azurerm_virtual_network.spoke.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
}

resource "azurerm_virtual_network_peering" "spoke_to_hub" {
  name                         = "peer-spoke-to-hub"
  resource_group_name          = var.spoke_rg_name
  virtual_network_name         = azurerm_virtual_network.spoke.name
  remote_virtual_network_id    = azurerm_virtual_network.hub.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
}
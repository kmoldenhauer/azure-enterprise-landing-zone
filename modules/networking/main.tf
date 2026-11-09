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

# -----------------------------------------------------------------------------
# NETWORK SECURITY GROUP (NSG) FOR SPOKE WORKLOADS
# -----------------------------------------------------------------------------
resource "azurerm_network_security_group" "workload" {
  name                = "nsg-workload-${var.location}"
  location            = var.location
  resource_group_name = var.spoke_rg_name
  tags                = var.tags

  # Rule: Allow HTTPS (Port 443) ONLY from the Hub VNet IP range
  security_rule {
    name                       = "Allow-HTTPS-From-Hub"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = var.hub_vnet_cidr
    destination_address_prefix = "*"
  }
}

# Associate the NSG directly to the Workload Subnet
resource "azurerm_subnet_network_security_group_association" "workload" {
  subnet_id                 = azurerm_subnet.workload.id
  network_security_group_id = azurerm_network_security_group.workload.id
}
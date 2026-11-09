variable "hub_rg_name" {
  type        = string
  description = "Name of the Hub Resource Group."
}

variable "spoke_rg_name" {
  type        = string
  description = "Name of the Spoke Resource Group."
}

variable "location" {
  type        = string
  description = "Azure region for the network deployment."
}

variable "tags" {
  type        = map(string)
  description = "Resource tags."
}

variable "hub_vnet_cidr" {
  type        = string
  description = "Address space for Hub VNet."
  default     = "10.0.0.0/16"
}

variable "spoke_vnet_cidr" {
  type        = string
  description = "Address space for Spoke VNet."
  default     = "10.1.0.0/16"
}

variable "firewall_subnet_cidr" {
  type        = string
  description = "Subnet CIDR for Azure Firewall."
  default     = "10.0.1.0/24"
}

variable "workload_subnet_cidr" {
  type        = string
  description = "Subnet CIDR for application workloads."
  default     = "10.1.1.0/24"
}
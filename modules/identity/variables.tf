variable "resource_group_name" {
  type        = string
  description = "Resource group where Key Vault will be created."
}

variable "location" {
  type        = string
  description = "Azure region for Key Vault."
}

variable "tags" {
  type        = map(string)
  description = "Resource tags."
}

variable "project_name" {
  type        = string
  description = "Short project name used for naming conventions."
}

variable "environment" {
  type        = string
  description = "Deployment environment (e.g., dev, prod)."
}
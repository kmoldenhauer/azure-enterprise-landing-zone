# -----------------------------------------------------------------------------
# TERRAFORM & AZURE PROVIDER CONFIGURATION
# -----------------------------------------------------------------------------
terraform {
  required_version = ">= 1.5.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.90.0"
    }
  }
}

provider "azurerm" {
  features {}
}

# -----------------------------------------------------------------------------
# FOUNDATIONAL RESOURCE GROUPS
# -----------------------------------------------------------------------------

# Hub Resource Group (Central Security & Shared Services)
resource "azurerm_resource_group" "hub" {
  name     = "rg-${var.project_name}-hub-${var.environment}-${var.location}"
  location = var.location
  tags     = var.tags
}

# Spoke Resource Group (Workloads & Application Resources)
resource "azurerm_resource_group" "spoke" {
  name     = "rg-${var.project_name}-spoke-${var.environment}-${var.location}"
  location = var.location
  tags     = var.tags
}
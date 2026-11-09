variable "project_name" {
  type        = string
  description = "Short name of the project used in resource naming conventions."
  default     = "alz"
}

variable "environment" {
  type        = string
  description = "Deployment environment (e.g., dev, test, prod)."
  default     = "dev"
}

variable "location" {
  type        = string
  description = "Azure region where resources will be deployed."
  default     = "eastus"
}

variable "tags" {
  type        = map(string)
  description = "Standard resource tags for governance and cost management."
  default = {
    Project   = "Azure-Landing-Zone"
    ManagedBy = "Terraform"
    AZ104_Lab = "True"
  }
}
# Azure Enterprise Landing Zone (Terraform)

An enterprise-grade, modular Azure Landing Zone deployed using **Terraform** adhering to Microsoft Cloud Adoption Framework (CAF) best practices and Zero Trust security principles.

---

## 🏗️ Architecture Overview

The infrastructure implements a classic **Hub-and-Spoke topology**:

* **Hub Network (`vnet-hub`):** Central management zone hosting core infrastructure such as `AzureFirewallSubnet` (`10.0.1.0/24`) for centralized outbound/inbound traffic inspection.
* **Spoke Network (`vnet-spoke`):** Dedicated workload zone hosting application subnets (`10.1.1.0/24`) isolated from direct public internet access.
* **VNet Peering:** High-speed, non-transitive bidirectional peering enabling private routing between Hub and Spoke.
* **Network Security Group (NSG):** Enforces Zero Trust boundary on workload subnets, permitting inbound HTTPS (`Port 443`) exclusively from the Hub VNet.
* **Identity & Key Vault:** Centralized Azure Key Vault (`kv-alz-dev-*`) configured with dynamic suffix generation and tenant-scoped Access Policies for secrets management.

---

## 📁 Repository Structure

```text
azure-enterprise-landing-zone/
├── environments/
│   └── dev.tfvars           # Environment profile parameters (Dev)
├── modules/
│   ├── identity/            # Key Vault & access policy resources
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   └── networking/          # Hub/Spoke VNets, subnets, peering & NSG
│       ├── main.tf
│       ├── outputs.tf
│       └── variables.tf
├── main.tf                  # Root orchestration blueprint
├── variables.tf             # Global input declarations
└── outputs.tf               # Global resource outputs

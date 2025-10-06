
# Terraform Azure AI Foundry

This project deploys a secure, extensible, and integrated environment for running AI Foundry workloads in production on Azure.

## Deployed Resources

- Azure Resource Group
- Azure Virtual Network
- Azure Key Vault
- Azure Container Registry
- Azure OpenAI Service
- Azure AI Search
- Azure Log Analytics Workspace
- Azure Application Insights

All services are connected via private endpoints to the virtual network.

## Usage

1. Clone this repository.
2. Initialize Terraform: `terraform init`
3. Review the plan: `terraform plan`
4. Apply the changes: `terraform apply`

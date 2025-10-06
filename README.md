
# Terraform Azure AI Foundry

This project deploys a secure, extensible, and integrated environment for running AI Foundry workloads in production on Azure. The infrastructure is defined using Terraform and organized into reusable modules for better maintainability and scalability.

## Introduction

Deploying AI models from development to production can be a complex process. This Terraform project aims to simplify that by providing a robust, scalable, and maintainable infrastructure for your AI applications on Azure, adhering to Microsoft Well-Architected Framework (WAF) recommendations.

## Architecture Diagram

![Architecture Diagram](image.png)


## Architecture Overview

The project deploys the following core Azure resources, all configured for network isolation where applicable, ensuring a secure environment for AI workloads:

-   **Resource Group:** A logical container for all Azure resources.
-   **Virtual Network (VNet) & Subnet:** Provides a private and isolated network space in Azure, allowing resources to communicate securely.
-   **Azure Key Vault:** Securely stores and manages sensitive information like API keys, passwords, and certificates.
-   **Azure Container Registry (ACR):** A managed registry service for building, storing, and managing container images.
-   **Azure OpenAI Service:** Provides access to OpenAI's powerful language models.
-   **Azure AI Search:** A search-as-a-service solution that allows developers to add a sophisticated search experience to their applications.
-   **Azure Log Analytics Workspace:** A centralized service for collecting, analyzing, and acting on telemetry data from Azure and on-premises environments.
-   **Azure Application Insights:** An Application Performance Management (APM) service for monitoring live web applications.

All services that support private endpoints are configured to connect to the Virtual Network via private endpoints, enhancing security by keeping traffic within the Azure backbone network.

## Modular Structure

The Terraform code is organized into the following modules, each responsible for a specific set of resources:

-   **`resource_group`**:
    -   **Purpose:** Creates and manages the Azure Resource Group where all other resources will reside.
    -   **Resources:** `azurerm_resource_group`
    -   **Inputs:** `resource_group_name`, `location`
    -   **Outputs:** `name`, `location`, `id`

-   **`network`**:
    -   **Purpose:** Deploys the core networking components, including the Virtual Network and a dedicated Subnet.
    -   **Resources:** `azurerm_virtual_network`, `azurerm_subnet`
    -   **Inputs:** `vnet_name`, `address_space`, `location`, `resource_group_name`, `subnet_name`, `subnet_address_prefixes`
    -   **Outputs:** `vnet_id`, `vnet_name`, `subnet_id`, `subnet_name`

-   **`key_vault`**:
    -   **Purpose:** Provisions an Azure Key Vault and configures its private endpoint for secure access within the VNet.
    -   **Resources:** `azurerm_key_vault`, `azurerm_private_dns_zone`, `azurerm_private_dns_zone_virtual_network_link`, `azurerm_private_endpoint`
    -   **Inputs:** `kv_name`, `location`, `resource_group_name`, `tenant_id`, `vnet_id`, `subnet_id`
    -   **Outputs:** `id`, `name`

-   **`container_registry`**:
    -   **Purpose:** Sets up an Azure Container Registry and integrates it with the VNet via a private endpoint.
    -   **Resources:** `azurerm_container_registry`, `azurerm_private_dns_zone`, `azurerm_private_dns_zone_virtual_network_link`, `azurerm_private_endpoint`
    -   **Inputs:** `acr_name`, `location`, `resource_group_name`, `vnet_id`, `subnet_id`
    -   **Outputs:** `id`, `name`, `login_server`

-   **`openai`**:
    -   **Purpose:** Deploys an Azure OpenAI Service instance with private endpoint connectivity.
    -   **Resources:** `azurerm_cognitive_account`, `azurerm_private_dns_zone`, `azurerm_private_dns_zone_virtual_network_link`, `azurerm_private_endpoint`
    -   **Inputs:** `openai_name`, `location`, `resource_group_name`, `vnet_id`, `subnet_id`
    -   **Outputs:** `id`, `name`, `endpoint`

-   **`search`**:
    -   **Purpose:** Creates an Azure AI Search service and configures its private endpoint.
    -   **Resources:** `azurerm_search_service`, `azurerm_private_dns_zone`, `azurerm_private_dns_zone_virtual_network_link`, `azurerm_private_endpoint`
    -   **Inputs:** `search_name`, `location`, `resource_group_name`, `vnet_id`, `subnet_id`
    -   **Outputs:** `id`, `name`

-   **`log_analytics`**:
    -   **Purpose:** Provisions an Azure Log Analytics Workspace and an associated Application Insights instance for monitoring and logging.
    -   **Resources:** `azurerm_log_analytics_workspace`, `azurerm_application_insights`
    -   **Inputs:** `la_name`, `ai_name`, `location`, `resource_group_name`
    -   **Outputs:** `la_id`, `la_name`, `ai_id`, `ai_name`, `ai_instrumentation_key`

## Getting Started

### Prerequisites

Before you begin, ensure you have the following installed:

-   [Terraform](https://www.terraform.io/downloads.html)
-   [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)
-   An Azure subscription with Contributor permissions.

### Installation

1.  **Clone this repository:**
    ```bash
    git clone <repository_url>
    cd terraform-azure-ai-foundry
    ```

2.  **Log in to Azure:**
    ```bash
    az login
    ```

3.  **Initialize Terraform:**
    ```bash
    terraform init
    ```

4.  **Review the plan:**
    ```bash
    terraform plan
    ```

5.  **Apply the changes:**
    ```bash
    terraform apply
    ```

## Deployment Strategies (Terraform on Azure)

This project focuses on deploying the foundational Azure infrastructure for AI applications using Terraform. Once the infrastructure is provisioned, you can integrate your AI application using various deployment methods, such as:

-   **Azure Kubernetes Service (AKS):** For containerized AI applications requiring orchestration and scaling.
-   **Azure Container Instances (ACI):** For running isolated containers without managing underlying infrastructure.
-   **Azure Machine Learning:** For end-to-end machine learning lifecycle management, including model deployment.

## Monitoring and Logging

The deployed infrastructure includes Azure Log Analytics Workspace and Application Insights to provide comprehensive monitoring and logging capabilities for your AI applications. You can use these services to:

-   Collect and analyze logs from all Azure resources.
-   Monitor application performance and identify bottlenecks.
-   Set up alerts for critical events.
-   Visualize data with dashboards.

## Security Best Practices

This Terraform project incorporates several security best practices:

-   **Network Isolation:** All services are configured with private endpoints, ensuring traffic remains within your Azure VNet and is not exposed to the public internet.
-   **Key Management:** Azure Key Vault is used to securely store sensitive information.
-   **Role-Based Access Control (RBAC):** Azure RBAC is recommended for managing access to resources.
-   **Managed Identities:** Utilize Managed Identities for Azure resources to authenticate to services without managing credentials.

## Contributing

We welcome contributions! If you have suggestions for improvements or new features, please open an issue or submit a pull request.

## License

This project is licensed under the MIT License.

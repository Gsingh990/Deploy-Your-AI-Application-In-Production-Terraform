# Terraform Azure AI Foundry

This project deploys a secure, extensible, and integrated environment for running AI Foundry workloads in production on Azure. The infrastructure is defined using Terraform and organized into reusable modules for better maintainability and scalability.

## Introduction

Deploying AI models from development to production can be a complex process. This Terraform project aims to simplify that by providing a robust, scalable, and maintainable infrastructure for your AI applications on Azure, adhering to Microsoft Well-Architected Framework (WAF) recommendations.

## Architecture Diagram

![Architecture Diagram](image.png)

## Architecture Overview

The provided architecture diagram illustrates a comprehensive and secure environment for deploying AI applications in production on Azure. The core components and their interactions are designed to ensure high availability, scalability, and robust security.

### Key Components:

-   **Client Virtual Network (VNet):** This is the central private network space in Azure, hosting the majority of the application's resources. It's protected by **DDoS protection** to safeguard against volumetric and protocol attacks.

    -   **VmSubnet:** A dedicated subnet within the VNet for hosting virtual machines, including a **Jumpbox VM**. The Jumpbox VM serves as a secure, hardened access point for administrators and data scientists to manage resources within the private network. Access to the Jumpbox VM is secured using **Microsoft Entra ID and multi-factor authentication**.
    -   **AzureBastionSubnet:** A specialized subnet for **Azure Bastion**, which provides secure and seamless RDP/SSH connectivity to VMs directly from the Azure portal over SSL, eliminating the need for public IP addresses on the VMs.
    -   **Agent Client Subnet:** A subnet designated for agent or client applications that need to interact with the AI services.
    -   **Private Endpoints:** All Azure platform services (PaaS) are integrated into the VNet using Private Endpoints. This ensures that traffic to these services traverses the Azure backbone network privately, enhancing security and reducing exposure to the public internet. Services connected via private endpoints include:
        -   **Storage Account:** For persistent data storage.
        -   **Key Vault:** Securely manages secrets, keys, and certificates.
        -   **Container Registry (ACR):** Stores and manages Docker container images.
        -   **Application Insights & Log Analytics:** For application performance monitoring and centralized logging.
        -   **AI Foundry Account (AI Services):** The core AI platform services.
        -   **Azure AI Search:** Provides search capabilities for the AI application.
        -   **Azure SQL & Cosmos DB:** Relational and NoSQL database services.
        -   **App Storage Account:** Additional storage for application data.

-   **App Service Environment (ASE):** A fully isolated and dedicated environment for running web applications at high scale. It can host multiple **App Service Instances** (Zone 1 to Zone n) for the AI application's front-end or API layer. **Managed Identities** are utilized by the App Service Environment for secure authentication to other Azure services.

-   **API Management (APIM):** Deployed within its own `apim-subnet`, APIM acts as a facade for the backend AI APIs, enabling secure, scalable, and managed access for clients. It handles API publishing, versioning, security policies, and analytics.

-   **Application Gateway:** Residing in a `gateway-subnet`, the Application Gateway is a web traffic load balancer that enables you to manage traffic to your web applications. It provides features like SSL termination, cookie-based session affinity, and web application firewall (WAF) capabilities.

-   **Internet & Clients:** External clients access the application securely through the Application Gateway and API Management, which are exposed to the internet. The diagram also shows integration with **External APIs**.

-   **Azure Monitor:** Provides comprehensive monitoring of the entire Azure infrastructure, collecting metrics, logs, and traces for analysis and alerting.

### Data Flow and Security:

-   Users and workloads within the client's virtual network can utilize private endpoints to access managed resources and the AI Foundry project securely.
-   Tenant users log in to the Jumpbox VM using Microsoft Entra ID and multi-factor authentication for secure management access.
-   All internal communication between services leverages private endpoints and the VNet, minimizing public exposure.
-   External access is controlled and secured via Application Gateway and API Management.

## Modular Structure

The Terraform code is organized into the following modules, each responsible for a specific set of resources:

-   **`resource_group`**:
    -   **Purpose:** Creates and manages the Azure Resource Group where all other resources will reside.
    -   **Resources:** `azurerm_resource_group`
    -   **Inputs:** `resource_group_name`, `location`
    -   **Outputs:** `name`, `location`, `id`

-   **`network`**:
    -   **Purpose:** Deploys the core networking components, including the Virtual Network and dedicated subnets (`VmSubnet`, `AzureBastionSubnet`, `Agent client subnet`).
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

## Network Topology and Security

The network architecture is designed for maximum security and isolation:

-   **Client Virtual Network:** The foundation of the secure environment, providing a private IP space.
-   **Subnets:** Dedicated subnets for different functionalities (VMs, Bastion, Agent clients) ensure logical segmentation.
-   **Private Endpoints:** All Azure PaaS services are accessed exclusively through private endpoints, eliminating public internet exposure for data traffic.
-   **Private DNS Zones:** Integrated with private endpoints to ensure proper name resolution within the VNet.
-   **Azure Bastion:** Provides secure, RDP/SSH access to VMs without exposing them to the public internet.
-   **DDoS Protection:** Enabled on the VNet to protect against network-layer attacks.
-   **Application Gateway & API Management:** Act as secure entry points for external traffic, providing load balancing, WAF capabilities, and API governance.

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
-   **Secure Access to VMs:** Jumpbox VMs and Azure Bastion provide secure and controlled access to virtual machines.
-   **DDoS Protection:** Protects the virtual network from distributed denial-of-service attacks.

## Contributing

We welcome contributions! If you have suggestions for improvements or new features, please open an issue or submit a pull request.

## License

This project is licensed under the MIT License.
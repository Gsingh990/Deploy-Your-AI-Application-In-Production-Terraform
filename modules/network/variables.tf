
variable "vnet_name" {
  description = "The name of the virtual network."
  type        = string
}

variable "address_space" {
  description = "The address space for the virtual network."
  type        = list(string)
}

variable "location" {
  description = "The Azure region where the resources will be created."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "vm_subnet_name" {
  description = "The name of the VM subnet."
  type        = string
  default     = "VmSubnet"
}

variable "vm_subnet_address_prefixes" {
  description = "The address prefixes for the VM subnet."
  type        = list(string)
  default     = ["10.0.1.0/24"]
}

variable "bastion_subnet_name" {
  description = "The name of the Azure Bastion subnet."
  type        = string
  default     = "AzureBastionSubnet"
}

variable "bastion_subnet_address_prefixes" {
  description = "The address prefixes for the Azure Bastion subnet."
  type        = list(string)
  default     = ["10.0.2.0/27"]
}

variable "agent_client_subnet_name" {
  description = "The name of the agent client subnet."
  type        = string
  default     = "AgentClientSubnet"
}

variable "agent_client_subnet_address_prefixes" {
  description = "The address prefixes for the agent client subnet."
  type        = list(string)
  default     = ["10.0.3.0/24"]
}

variable "enable_ddos_protection" {
  description = "Whether to enable DDoS Protection Plan for the VNet."
  type        = bool
  default     = false
}

variable "ddos_protection_plan_name" {
  description = "The name of the DDoS Protection Plan."
  type        = string
  default     = "ai-foundry-ddos-plan"
}

variable "vm_subnet_delegations" {
  description = "A list of service delegations for the VM subnet."
  type        = list(string)
  default     = []
}

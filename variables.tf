variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
  default     = "ai-foundry-rg"
}

variable "location" {
  description = "The Azure region where the resources will be created."
  type        = string
  default     = "West US 2"
}

variable "sql_admin_password" {
  description = "The administrator password for the SQL server."
  type        = string
  sensitive   = true
}

variable "publisher_name" {
  description = "The name of the API Management publisher."
  type        = string
  default     = "AI Foundry"
}

variable "publisher_email" {
  description = "The email of the API Management publisher."
  type        = string
  default     = "admin@aifoundry.com"
}

variable "vm_admin_password" {
  description = "The administrator password for the Virtual Machine."
  type        = string
  sensitive   = true
}
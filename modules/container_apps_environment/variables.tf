
variable "ca_env_name" {
  description = "The name of the Container Apps Environment."
  type        = string
}

variable "location" {
  description = "The Azure region where the resources will be created."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "log_analytics_workspace_id" {
  description = "The ID of the Log Analytics Workspace to associate with the Container Apps Environment."
  type        = string
}

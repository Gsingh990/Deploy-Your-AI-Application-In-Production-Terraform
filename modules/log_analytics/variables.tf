
variable "la_name" {
  description = "The name of the log analytics workspace."
  type        = string
}

variable "ai_name" {
  description = "The name of the application insights."
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

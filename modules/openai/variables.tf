
variable "openai_name" {
  description = "The name of the OpenAI service."
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

variable "vnet_id" {
  description = "The ID of the virtual network."
  type        = string
}

variable "subnet_id" {
  description = "The ID of the subnet."
  type        = string
}

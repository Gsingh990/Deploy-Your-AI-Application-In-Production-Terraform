
variable "sb_namespace_name" {
  description = "The name of the Service Bus Namespace."
  type        = string
}

variable "sb_queue_name" {
  description = "The name of the Service Bus Queue."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "location" {
  description = "The Azure region where the resources will be created."
  type        = string
}

variable "subnet_id" {
  description = "The ID of the subnet to associate with the private endpoint."
  type        = string
}

variable "vnet_id" {
  description = "The ID of the virtual network to link the private DNS zone."
  type        = string
}

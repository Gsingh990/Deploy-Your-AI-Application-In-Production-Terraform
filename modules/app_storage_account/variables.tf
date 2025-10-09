variable "app_storage_account_name" {
  description = "The name of the application storage account."
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

variable "private_dns_zone_ids" {
  description = "A list of Private DNS Zone IDs to associate with the private endpoint."
  type        = list(string)
}

variable "bastion_host_name" {
  description = "The name of the Bastion Host."
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
  description = "The ID of the subnet to deploy the Bastion Host into."
  type        = string
}

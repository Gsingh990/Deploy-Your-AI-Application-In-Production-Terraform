
variable "vm_name" {
  description = "The name of the Virtual Machine."
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
  description = "The ID of the subnet to deploy the Virtual Machine into."
  type        = string
}

variable "admin_username" {
  description = "The administrator username for the Virtual Machine."
  type        = string
}

variable "admin_password" {
  description = "The administrator password for the Virtual Machine."
  type        = string
  sensitive   = true
}

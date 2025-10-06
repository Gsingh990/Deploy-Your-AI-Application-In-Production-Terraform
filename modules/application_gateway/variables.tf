
variable "ag_name" {
  description = "The name of the Application Gateway."
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
  description = "The ID of the subnet to deploy the Application Gateway into."
  type        = string
}

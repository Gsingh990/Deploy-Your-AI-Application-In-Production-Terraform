
variable "ase_name" {
  description = "The name of the App Service Environment."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "subnet_id" {
  description = "The ID of the subnet to deploy the App Service Environment into."
  type        = string
}

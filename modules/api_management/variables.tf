
variable "apim_name" {
  description = "The name of the API Management service."
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

variable "publisher_name" {
  description = "The name of the publisher."
  type        = string
}

variable "publisher_email" {
  description = "The email of the publisher."
  type        = string
}

variable "subnet_id" {
  description = "The ID of the subnet to deploy the API Management service into."
  type        = string
}

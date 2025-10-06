
variable "sql_server_name" {
  description = "The name of the SQL server."
  type        = string
}

variable "sql_database_name" {
  description = "The name of the SQL database."
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

variable "sql_admin_login" {
  description = "The administrator login name for the SQL server."
  type        = string
}

variable "sql_admin_password" {
  description = "The administrator password for the SQL server."
  type        = string
  sensitive   = true
}

variable "subnet_id" {
  description = "The ID of the subnet to associate with the private endpoint."
  type        = string
}

variable "vnet_id" {
  description = "The ID of the virtual network to link the private DNS zone."
  type        = string
}

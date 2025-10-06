
resource "azurerm_app_service_environment_v3" "ase" {
  name                = var.ase_name
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_id
  cluster_setting {
    name  = "InternalLoadBalancingMode"
    value = "3"
  }
  tags = {
    environment = "production"
  }
}

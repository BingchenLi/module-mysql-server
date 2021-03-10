provider "azurerm" {
  features {}
  subscription_id = "subscription_id"
}

module "MysqlServer" {
  source = "../../module-mysql-server"

  resource_group_name = "rg"

  # mysql server
  mysql_server_name   = "mysql"
  administrator_login = "myadm"

  # private endpoint
  vnet_name   = "vnet"
  vnet_rg     = "vnet-rg"
  subnet_name = "subnet-1"
}

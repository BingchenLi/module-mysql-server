resource "random_password" "administrator_login_password" {
  length           = 16
  special          = true
  min_numeric      = 1
  min_special      = 1
  override_special = "$#%"
  keepers = {
    # Generate a new password each time when switch to a new mysql server name
    # https://registry.terraform.io/providers/hashicorp/random/latest/docs
    # https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password
    mysql_server_name = var.mysql_server_name
  }
}

resource "azurerm_mysql_server" "mysql_server" {
  name                         = random_password.administrator_login_password.keepers.mysql_server_name
  location                     = data.azurerm_resource_group.db_rg.location
  resource_group_name          = data.azurerm_resource_group.db_rg.name
  administrator_login          = var.administrator_login
  administrator_login_password = random_password.administrator_login_password.result

  sku_name   = var.sku_name
  storage_mb = var.storage_mb
  version    = var.mysql_server_version

  auto_grow_enabled            = var.auto_grow_enabled
  backup_retention_days        = var.backup_retention_days
  geo_redundant_backup_enabled = var.geo_redundant_backup_enabled
  ssl_enforcement_enabled      = var.ssl_enforcement_enabled
}

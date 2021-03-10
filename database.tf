resource "azurerm_mysql_database" "mysql_db" {
  count               = var.database_name == null ? 0 : length(var.database_name)
  charset             = "utf8"
  collation           = "utf8_general_ci"
  name                = var.database_name[count.index]
  resource_group_name = data.azurerm_resource_group.db_rg.name
  server_name         = azurerm_mysql_server.mysql_server.name
}

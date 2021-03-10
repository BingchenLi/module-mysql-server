# Private endpoint for the mysql server
resource "azurerm_private_endpoint" "mysqlpe" {
  name                = "${var.mysql_server_name}pe"
  location            = data.azurerm_resource_group.db_rg.location
  resource_group_name = data.azurerm_resource_group.db_rg.name
  subnet_id           = data.azurerm_subnet.private_link_endpoint.id

  private_service_connection {
    name                           = "${var.mysql_server_name}pl"
    is_manual_connection           = var.is_manual_connection
    private_connection_resource_id = azurerm_mysql_server.mysql_server.id
    subresource_names              = ["mysqlServer"]
  }
}

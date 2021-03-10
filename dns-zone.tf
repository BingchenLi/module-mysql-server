# Private DNS zone configuration for the private endpoint
resource "azurerm_private_dns_zone" "plink_dns_zone" {
  name                = "privatelink.mysql.database.azure.com"
  resource_group_name = data.azurerm_resource_group.db_rg.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "zone_to_vnet_link" {
  name                  = var.private_dns_zone_virtual_network_link_name
  resource_group_name   = data.azurerm_resource_group.db_rg.name
  private_dns_zone_name = azurerm_private_dns_zone.plink_dns_zone.name
  virtual_network_id    = data.azurerm_virtual_network.vnet.id
}

resource "azurerm_private_dns_a_record" "pe_a_record" {
  name                = var.mysql_server_name
  zone_name           = azurerm_private_dns_zone.plink_dns_zone.name
  resource_group_name = data.azurerm_resource_group.db_rg.name
  ttl                 = var.ttl
  records             = [azurerm_private_endpoint.mysqlpe.private_service_connection[0].private_ip_address]
}

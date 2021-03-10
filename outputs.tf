output "mysql_server_pe_name" {
  value = azurerm_private_endpoint.mysqlpe.name
}

output "mysql_server_pe_ip_address" {
  value = azurerm_private_endpoint.mysqlpe.private_service_connection[0].private_ip_address
}

output "mysql_server_private_service_connection" {
  value = azurerm_private_endpoint.mysqlpe.private_service_connection[0].name
}

output "mysql_fqdn" {
  value = azurerm_mysql_server.mysql_server.fqdn
}

output "mysql_server_administrator_login" {
  value = local.administrator_login
}

output "mysql_server_administrator_login_password" {
  value = azurerm_mysql_server.mysql_server.administrator_login_password
}

output "database_name" {
  value = azurerm_mysql_database.mysql_db[*].name
}

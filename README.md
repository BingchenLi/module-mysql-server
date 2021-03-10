# Azure Database for MySQL

## Table of Contents

- [About the module](#about-the-module)
- [Usage](#usage)
  - [Prerequisites](#prerequisites)
  - [Module call](#module-call)
  - [Input](#input)
  - [Output](#output)
- [Resources](#resources)

## About the module

This module defines an **Azure Database for MySQL server (PaaS)** with a **private endpoint** and associated **private DNS zone**, which can be integrated into the VNet and the existing resources group. Optionally, you can create database(s) in the server. Different projects or container groups can share this
MySQL server by having their own database in it.

## Usage

### Prerequisites

1.The module assumes that the following resources are already created:

- Virtual network with a subnet for the private endpoint and private DNS zone to connect
- A resource group where all resource are created in

  2.The subnet where the private endpoint is deployed needs to explicitly disable subnet endpoint policies.

- Using Azure PowerShell/CLI : https://docs.microsoft.com/en-us/azure/private-link/disable-private-endpoint-network-policy

- Using Terraform : https://www.terraform.io/docs/providers/azurerm/r/subnet.html#enforce_private_link_endpoint_network_policies

  > Note : The private link feature is only available for Azure Database for MySQL servers in the General Purpose or Memory Optimized pricing tiers. Ensure the database server **sku** is in one of these pricing tiers.

### Module call

To use this module, you need to provide the `subscription id` that you want resources to be deployed to via `azuread provider`.

The following code example creates an Azure database for MySQL named `mysqlserver` with administrator user `myadm` in resource group `mysql-rg`. The private endpoint integrates the `mysqlserver` into `subnet` in `vnet`. Two databases `database_1` and `database_2` are created with `charset="utf8"` and `collation="utf8_general_ci"`.

Example code:

```terraform

provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}

module "MysqlServer" {
  source = "local_path_of_module_dir"

  resource_group_name = "mysql-rg"

  # mysql server
  mysql_server_name   = "mysqlserver"
  administrator_login = "myadm"

  # private endpoint
  vnet_name   = "vnet"
  vnet_rg     = "vnet-rg"
  subnet_name = "subnet"

  # optional
  database_name = ["database_1", "database_2"]
}

```

### Input

| Name                                       | Description                                                                                                                                                                                                                                                | Type           | Default          | Required |
| ------------------------------------------ | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------- | ---------------- | :------: |
| resource_group_name                        | The resource group for resources deployed in this module                                                                                                                                                                                                   | `string`       | n/a              |   yes    |
| mysql_server_name                          | Name of the MySQL Server                                                                                                                                                                                                                                   | `string`       | n/a              |   yes    |
| administrator_login                        | MySQL administrator login                                                                                                                                                                                                                                  | `string`       | n/a              |   yes    |
| vnet_name                                  | VNet which the private endpoint will be connected to                                                                                                                                                                                                       | `string`       | n/a              |   yes    |
| vnet_rg                                    | Resource group of the VNet                                                                                                                                                                                                                                 | `string`       | n/a              |   yes    |
| subnet_name                                | Subnet which the private endpoint will be connected to                                                                                                                                                                                                     | `string`       | n/a              |   yes    |
| prefix                                     | An optional prefix to use in naming schemes when unique names are required                                                                                                                                                                                 | `string`       | `""`             |    no    |
| sku_name                                   | MySQL server sku. Private link feature is only available for General Purpose or Memory Optimized pricing tiers. This name may get updated with newer versions, check the API. https://www.terraform.io/docs/providers/azurerm/r/mysql_server.html#sku_name | `string`       | `"GP_Gen5_2"`    |    no    |
| auto_grow_enabled                          | Enable/Disable auto-growing of the storage.                                                                                                                                                                                                                | `bool`         | `false`          |    no    |
| backup_retention_days                      | Backup retention days for the server, supported values are between 7 and 35 days.                                                                                                                                                                          | `number`       | `7`              |    no    |
| ssl_enforcement_enabled                    | Force usage of SSL                                                                                                                                                                                                                                         | `bool`         | `false`          |    no    |
| geo_redundant_backup_enabled               | Turn Geo-redundant server backups on/off. Not available for the Basic tier.                                                                                                                                                                                | `bool`         | `false`          |    no    |
| mysql_server_version                       | Valid are 5.6, 5.7 and 8.0                                                                                                                                                                                                                                 | `string`       | `"5.7"`          |    no    |
| storage_mb                                 | Max storage allowed for a server. Possible values are between 5120 MB(5GB) and 1048576 MB(1TB) for the Basic SKU and between 5120 MB(5GB) and 4194304 MB(4TB) for General Purpose/Memory Optimized SKUs.                                                   | `number`       | `5120`           |    no    |
| is_manual_connection                       | The Private Endpoint require Manual Approval from the remote resource owner or not.                                                                                                                                                                        | `bool`         | `false`          |    no    |
| private_dns_zone_virtual_network_link_name | Name of the link that enables DNS resolution and registration inside Azure Virtual Networks using Azure Private DNS                                                                                                                                        | `string`       | `"mysqldnslink"` |    no    |
| ttl                                        | The Time To Live (TTL) of the DNS record in seconds.                                                                                                                                                                                                       | `number`       | `300`            |    no    |
| database_name                              | The list of database names.                                                                                                                                                                                                                                | `list(string)` | `null`           |    no    |

### output

| Name                                      | Description                                   |
| ----------------------------------------- | --------------------------------------------- |
| mysql_fqdn                                | FQDN of the MySQL server                      |
| mysql_server_administrator_login          | Administrator login for MySQL server          |
| mysql_server_administrator_login_password | Administrator login password for MySQL server |
| mysql_server_pe_name                      | Private endpoint for MySQL server             |
| mysql_server_pe_ip_address                | Private endpoint ip address for MySQL server  |
| mysql_server_private_service_connection   | Private service connection for MySQL server   |
| database_name                             | Database names                                |

## Resources

This list contains all the resources this module may create. The module can create zero or more of each of these resources depending on the `count` value. The count value is determined at runtime. The goal of this page is to present the types of resources that may be created.

- `azurerm_mysql_server.mysql_server`
- `azurerm_private_endpoint.mysqlpe`
- `azurerm_private_dns_zone.plink_dns_zone`
- `azurerm_private_dns_zone_virtual_network_link.zone_to_vnet_link`
- `azurerm_private_dns_a_record.pe_a_record`
- `azurerm_mysql_database.mysql_db`

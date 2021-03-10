variable "prefix" {
  type        = string
  default     = ""
  description = "An optional prefix to use in naming schemes when unique names are required."
}

variable "resource_group_name" {
  type        = string
  description = "The resource group for resources deployed in this module."
}

# Azure Database for MySQL
variable "mysql_server_name" {
  type        = string
  description = "Specifies the name of the MySQL Server. Changing this forces a new resource to be created. This needs to be globally unique within Azure."
}

variable "administrator_login" {
  type        = string
  description = "MySQL administrator login"
}

variable "sku_name" {
  type        = string
  default     = "GP_Gen5_2"
  description = "Specifies the SKU name for the MySQL Server. Private link feature is only available for General Purpose or Memory Optimized pricing tiers. This name may get updated with newer versions, check the API. https://www.terraform.io/docs/providers/azurerm/r/mysql_server.html#sku_name"
}

variable "storage_mb" {
  type        = number
  default     = 5120
  description = "Max storage allowed for a server. https://www.terraform.io/docs/providers/azurerm/r/mysql_server.html#storage_mb"
}

variable "mysql_server_version" {
  type        = string
  default     = "5.7"
  description = "Specifies the version of MySQL to use.Changing this forces a new resource to be created. https://www.terraform.io/docs/providers/azurerm/r/mysql_server.html#version"
}

variable "auto_grow_enabled" {
  type        = bool
  default     = false
  description = "Enable/Disable auto-growing of the storage."
}

variable "backup_retention_days" {
  type        = number
  default     = 7
  description = "Backup retention days for the server, supported values are between 7 and 35 days."
}

variable "geo_redundant_backup_enabled" {
  type        = bool
  default     = false
  description = "Turn Geo-redundant server backups on/off. Not available for the Basic tier."
}

variable "ssl_enforcement_enabled" {
  type        = bool
  default     = false
  description = "Force usage of SSL."
}

variable "database_name" {
  type        = list(string)
  default     = null
  description = "List of database name"
}

# Private endpoint
variable "vnet_name" {
  type        = string
  description = "VNet which the private endpoint will be connected to."
}

variable "vnet_rg" {
  type        = string
  description = "Resource group of the VNet."
}

variable "subnet_name" {
  type        = string
  description = "Subnet which the private endpoint will be connected to.  In order to deploy a Private Endpoint on a given subnet, an explicit disable setting is required on that subnet. https://docs.microsoft.com/en-us/azure/private-link/disable-private-endpoint-network-policy"
}

variable "is_manual_connection" {
  type        = bool
  default     = false
  description = "The Private Endpoint require Manual Approval from the remote resource owner or not. Changing this forces a new resource to be created."
}

# Private DNS Zone
variable "private_dns_zone_virtual_network_link_name" {
  type        = string
  default     = "mysqldnslink"
  description = "Name of the link that enables DNS resolution and registration inside Azure Virtual Networks using Azure Private DNS. Changing this forces a new resource to be created."
}

variable "ttl" {
  type        = number
  default     = 300
  description = "The Time To Live (TTL) of the DNS record in seconds."
}

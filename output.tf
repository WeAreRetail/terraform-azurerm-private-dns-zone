# define outputs
output "zone_id" {
  value       = azurerm_private_dns_zone.this.id
  description = "Private dns zone resource id."
}

output "zone_name" {
  value       = azurerm_private_dns_zone.this.name
  description = "Private dns zone name."
}

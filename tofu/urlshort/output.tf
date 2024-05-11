output "ipv4_addr" {
  value = azurerm_container_group.container.ip_address
}

output "domain" {
  value = cloudflare_record.record.name
}


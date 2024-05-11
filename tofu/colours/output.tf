output "ipv4_addr" {
  value = azurerm_container_group.container.ip_address
}

output "domains" {
  value = [cloudflare_record.record_colours.name, cloudflare_record.record_colors.name]
}


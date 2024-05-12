output "ipv4_addr" {
  value = azurerm_container_group.container.ip_address
}

output "urls" {
  value = [
    "https://${cloudflare_record.record_colours.name}/orange",
    "https://${cloudflare_record.record_colors.name}/orange",
  ]
}

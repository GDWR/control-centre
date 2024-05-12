output "ipv4_addr" {
  value = azurerm_container_group.container.ip_address
}

output "urls" {
  value = [
    "https://${cloudflare_record.record.name}"
  ]
}

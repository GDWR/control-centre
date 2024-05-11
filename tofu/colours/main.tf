resource "azurerm_resource_group" "rg" {
  location = var.resource_group_location
  name     = "rg-colours"
}

resource "azurerm_container_group" "container" {
  name                = "cg-colours"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  ip_address_type     = "Public"
  os_type             = "Linux"
  restart_policy      = "Always"

  container {
    name   = "ci-colours"
    image  = "ghcr.io/gdwr/colours"
    cpu    = "0.1"
    memory = "0.2"

    ports {
      port     = 80
      protocol = "TCP"
    }
  }
} 

resource "cloudflare_record" "record_colours" {
  zone_id = var.cloudflare_zone_id
  name    = "colours.gdwr.me"
  value   = azurerm_container_group.container.ip_address
  type    = "A"
  proxied = true
  comment = "Managed by OpenTofu"
}

resource "cloudflare_record" "record_colors" {
  zone_id = var.cloudflare_zone_id
  name    = "colors.gdwr.me"
  value   = "colours.gdwr.me"
  type    = "CNAME"
  proxied = true
  comment = "Managed by OpenTofu"
}


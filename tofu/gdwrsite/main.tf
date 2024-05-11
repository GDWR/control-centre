resource "azurerm_resource_group" "rg" {
  location = var.resource_group_location
  name     = "rg-gdwrsite"
}

resource "azurerm_container_group" "container" {
  name                = "cg-gdwrsite"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  ip_address_type     = "Public"
  os_type             = "Linux"
  restart_policy      = var.restart_policy

  container {
    name   = "ci-gdwrsite"
    image  = "ghcr.io/gdwr/gdwrsite"
    cpu    = var.cpu_cores
    memory = var.memory_in_gb

    ports {
      port     = 80
      protocol = "TCP"
    }
  }
} 

resource "cloudflare_record" "record" {
  zone_id = var.cloudflare_zone_id
  name    = "gdwr.me"
  value   = azurerm_container_group.container.ip_address
  type    = "A"
  proxied = true
  comment = "Managed by OpenTofu"
}


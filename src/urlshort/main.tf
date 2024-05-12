resource "azurerm_resource_group" "rg" {
  location = var.resource_group_location
  name     = "rg-urlshort"
  tags = {
    Url = "https://urlshort.gdwr.me"
  }
}

resource "azurerm_container_group" "container" {
  name                = "cg-urlshort"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  ip_address_type     = "Public"
  os_type             = "Linux"
  restart_policy      = "Always"

  container {
    name   = "ci-urlshort"
    image  = "ghcr.io/gdwr/urlshort"
    cpu    = "0.1"
    memory = "0.1"
    environment_variables = {
      "NUXT_PUBLIC_BASE_URL" = "https://urlshort.gdwr.me"
      "NITRO_PORT" = 80
    }

    ports {
      port     = 80
      protocol = "TCP"
    }
  }

  container {
    name   = "ci-redis"
    image  = "redis:6.2-alpine"
    cpu    = "0.1"
    memory = "0.1"
  }
}

resource "cloudflare_record" "record" {
  zone_id = var.cloudflare_zone_id
  name    = "urlshort.gdwr.me"
  value   = azurerm_container_group.container.ip_address
  type    = "A"
  proxied = true
  comment = "Managed by OpenTofu"
}


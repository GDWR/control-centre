module "gdwrsite" {
  source = "./gdwrsite"
  resource_group_location = var.resource_group_location
  cloudflare_zone_id = var.cloudflare_zone_id
}

module "colours" {
  source = "./colours"
  resource_group_location = var.resource_group_location
  cloudflare_zone_id = var.cloudflare_zone_id
}


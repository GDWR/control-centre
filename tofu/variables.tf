variable "cloudflare_api_token" {
  type        = string
  description = "API Token for Cloudflare."
}

variable "cloudflare_zone_id" {
  type        = string
  description = "Zone ID for Cloudflare."
  default     = "2df8cd50bfcef6f0f4d1c6b7dc6cc27e"
}

variable "resource_group_location" {
  type        = string
  default     = "ukwest"
  description = "Location for all resources."
}


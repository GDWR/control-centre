variable "resource_group_location" {
  type        = string
  default     = "ukwest"
  description = "Location for all resources."
}

variable "cpu_cores" {
  type        = number
  description = "The number of CPU cores to allocate to the container."
  default     = 1
}

variable "memory_in_gb" {
  type        = number
  description = "The amount of memory to allocate to the container in gigabytes."
  default     = 1
}

variable "restart_policy" {
  type        = string
  description = "The behavior of Azure runtime if container has stopped."
  default     = "Always"
  validation {
    condition     = contains(["Always", "Never", "OnFailure"], var.restart_policy)
    error_message = "The restart_policy must be one of the following: Always, Never, OnFailure."
  }
}

variable "cloudflare_zone_id" {
  type        = string
  description = "Zone ID for Cloudflare."
  default     = "2df8cd50bfcef6f0f4d1c6b7dc6cc27e"
}


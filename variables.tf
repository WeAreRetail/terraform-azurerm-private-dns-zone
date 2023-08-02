variable "name" {
  type        = string
  description = "DNS Zone name"
}

variable "resource_group_name" {
  type        = string
  description = "Parent resource group name"
}

variable "virtual_network_name" {
  type        = string
  description = "Virtual network name"
  default     = null
}

variable "virtual_network_names" {
  type        = list(object({ name = string, vnet_name = string }))
  description = "Virtual network name"
  default     = []
}

variable "description" {
  type        = string
  default     = ""
  description = "Private DNS zone description"
}

variable "custom_tags" {
  type        = map(string)
  default     = {}
  description = "The custom tags to add on the resource."
}

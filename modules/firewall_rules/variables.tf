variable "ingress_rules" {
  type        = list(object({
    name                    = string
    description             = optional(string)
    disabled                = optional(bool, false)
    source_ranges           = optional(list(string))
    source_tags             = optional(list(string))
    source_service_accounts = optional(list(string))
    target_tags             = optional(list(string))
    target_service_accounts = optional(list(string))
    priority                = optional(number, 1000)
    allow                   = optional(list(object({
      protocol = string
      ports    = optional(list(string))
    })))
    log_config              = optional(object({ metadata = string }))
  }))
  default = []
}

variable "egress_rules" {
  type        = list(object({
    name                    = string
    description             = optional(string)
    disabled                = optional(bool, false)
    destination_ranges      = optional(list(string))
    source_tags             = optional(list(string))
    source_service_accounts = optional(list(string))
    target_tags             = optional(list(string))
    target_service_accounts = optional(list(string))
    priority                = optional(number, 1000)
    allow                   = optional(list(object({
      protocol = string
      ports    = optional(list(string))
    })))
    log_config              = optional(object({ metadata = string }))
  }))
  default = []
}

variable "network_name" {
  type        = string
  description = "Name of the VPC network."
}

variable "project_id" {
  type        = string
  description = "GCP project ID."
}

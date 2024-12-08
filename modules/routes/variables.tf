variable "project_id" {
  description = "The ID of the project where this VPC will be created"
  type        = string
}

variable "routes" {
  type        = list(map(string))
  description = "List of routes being created in this VPC"
  default     = []
}

variable "delete_default_internet_route" {
  description = "Whether to delete the default internet gateway route"
  type        = bool
  default     = false
}


variable "network_name" {
  description = "The name of the network where routes will be created"
  type        = string
}

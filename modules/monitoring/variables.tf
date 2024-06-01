variable "project_id" {
  description = "The ID of the project where the resources will be created."
  type        = string
}

variable "project_region" {
  description = "The REGION of the project where the resources will be created."
  type        = string
}

variable "uptime_checks" {
  description = "List of uptime checks."
  type = list(object({
    name     = string
    hostname = string
    path     = string
    period   = number
    timeout  = number
  }))
  default = []
}

variable "notification_channels" {
  description = "List of notification channels."
  type = list(object({
    type  = string
    email = string
  }))
  default = []
}

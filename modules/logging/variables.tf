variable "project_id" {
  description = "The ID of the project where the resources will be created."
  type        = string
}

variable "project_region" {
  description = "The REGION of the project where the resources will be created."
  type        = string
}

variable "log_sinks" {
  description = "List of log sinks to export logs to destinations."
  type = list(object({
    name        = string
    destination = string
    filter      = string
  }))
  default = []
}

variable "log_exclusions" {
  description = "List of log exclusions to filter out unwanted logs."
  type = list(object({
    name   = string
    filter = string
  }))
  default = []
}

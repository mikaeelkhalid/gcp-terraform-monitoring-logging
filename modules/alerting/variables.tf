variable "project_id" {
  description = "The ID of the project where the resources will be created."
  type        = string
}

variable "project_region" {
  description = "The REGION of the project where the resources will be created."
  type        = string
}

variable "alert_policies" {
  description = "List of alert policies."
  type = list(object({
    display_name = string
    conditions = list(object({
      display_name = string
      filter       = string
      comparison   = string
      threshold    = number
      duration     = string
    }))

    notification_channels = list(string)
  }))
  default = []
}

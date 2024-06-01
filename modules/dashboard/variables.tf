variable "project_id" {
  description = "The ID of the project where the resources will be created."
  type        = string
}

variable "project_region" {
  description = "The REGION of the project where the resources will be created."
  type        = string
}

variable "dashboards" {
  description = "List of dashboards in JSON format."

  type = list(object({
    display_name = string
    json_layout  = string
  }))

  default = []
}


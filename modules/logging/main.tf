provider "google" {
  project = var.project_id
  region  = var.project_region
}

resource "google_logging_project_sink" "sinks" {
  count        = length(var.log_sinks)
  name         = var.log_sinks[count.index].name
  destination  = var.log_sinks[count.index].destination
  filter       = var.log_sinks[count.index].filter
  unique_writer_identity = true
}

resource "google_logging_metric" "log_metrics" {
  count = length(var.log_exclusions)
  name        = var.log_exclusions[count.index].name
  filter      = var.log_exclusions[count.index].filter
  description = "Exclusion filter for logs"
}

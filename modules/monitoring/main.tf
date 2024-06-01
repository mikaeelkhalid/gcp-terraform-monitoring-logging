provider "google" {
  project = var.project_id
  region  = var.project_region
}

resource "google_monitoring_notification_channel" "channels" {
  count = length(var.notification_channels)

  type = "email"

  labels = {
    email_address = var.notification_channels[count.index].email
  }
}

resource "google_monitoring_uptime_check_config" "uptime_checks" {
  count        = length(var.uptime_checks)
  display_name = var.uptime_checks[count.index].name

  monitored_resource {
    type = "uptime_url"
    labels = {
      host = var.uptime_checks[count.index].hostname
    }
  }

  http_check {
    path = var.uptime_checks[count.index].path
  }

  timeout = format("%ds", var.uptime_checks[count.index].timeout)
  period  = format("%ds", var.uptime_checks[count.index].period)
}

provider "google" {
  project = var.project_id
  region  = var.project_region
}

resource "google_monitoring_alert_policy" "alert_policies" {
  count        = length(var.alert_policies)
  display_name = var.alert_policies[count.index].display_name

  combiner = "OR"

  conditions {
    display_name = var.alert_policies[count.index].conditions[count.index].display_name

    condition_threshold {
      filter          = var.alert_policies[count.index].conditions[count.index].filter
      comparison      = var.alert_policies[count.index].conditions[count.index].comparison
      duration        = var.alert_policies[count.index].conditions[count.index].duration
      threshold_value = var.alert_policies[count.index].conditions[count.index].threshold
    }
  }

  notification_channels = [var.alert_policies[count.index].notification_channels]
}

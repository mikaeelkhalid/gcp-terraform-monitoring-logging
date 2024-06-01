module "alerting_policy" {
  source = "../../modules/alerting"

  project_id     = "project-id"
  project_region = "project-region"

  alert_policies = [
    {
      display_name = "CPU Utilization > 80%"
      conditions = [
        {
          display_name = "CPU usage"
          filter       = "resource.type = \"gce_instance\" AND metric.type = \"compute.googleapis.com/instance/cpu/utilization\""
          comparison   = "COMPARISON_GT"
          threshold    = "0.8"
          duration     = "60s"
        }
      ]
      notification_channels = ["email"]
    }
  ]
}

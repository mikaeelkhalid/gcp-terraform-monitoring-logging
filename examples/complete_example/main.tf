module "logging" {
  source = "../../modules/logging"

  project_id     = "project-id"
  project_region = "project-region"

  log_sinks = [
    {
      name        = "log-sink"
      destination = "storage.googleapis.com/bucket-name"
      filter      = "logName:\"logs/cloudaudit.googleapis.com%2Factivity\""
    }
  ]

  log_exclusions = [
    {
      name   = "exclude-debug"
      filter = "severity=DEBUG"
    }
  ]
}

module "monitoring" {
  source = "../../modules/monitoring"

  project_id     = "project-id"
  project_region = "project-region"

  uptime_checks = [
    {
      name     = "uptime-check-name"
      hostname = "mikaeels.com"
      path     = "/health"
      period   = "60"
      timeout  = "10"
    }
  ]

  notification_channels = [
    {
      type  = "email"
      email = "iam@mikaeels.com"
    }
  ]
}

module "alerting_policy" {
  source = "../../modules/alerting"

  project_id     = "project-id"
  project_region = "project-region"

  alert_policies = [
    {
      display_name = "High CPU Usage"
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

module "dashboard" {
  source = "../../modules/dashboard"

  project_id     = "project-id"
  project_region = "project-region"

  dashboards = [
    {
      display_name = "CPU Dashboard"
      json_layout  = <<EOF
 {
  "displayName": "CPU Dashboard",
  "gridLayout": {
    "widgets": [
      {
        "title": "CPU Usage",
        "xyChart": {
          "dataSets": [
            {
              "timeSeriesQuery": {
                "timeSeriesFilter": {
                  "filter": "metric.type=\"compute.googleapis.com/instance/cpu/utilization\""
                }
              }
            }
          ]
        }
      }
    ]
  }
 }
 EOF
    }
  ]
}

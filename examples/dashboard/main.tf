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

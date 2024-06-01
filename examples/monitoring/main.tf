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

module "logging" {
  source     = "../../modules/logging"
  
  project_id = "project-id"
  project_region = "project-region"

  log_sinks = [
    {
      name        = "log-sink-name"
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

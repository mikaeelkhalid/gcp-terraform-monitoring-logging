provider "google" {
  project = var.project_id
  region  = var.project_region
}

resource "google_monitoring_dashboard" "dashboards" {
  count          = length(var.dashboards)
  dashboard_json = var.dashboards[count.index].json_layout
}

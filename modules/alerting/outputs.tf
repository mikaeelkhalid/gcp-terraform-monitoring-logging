output "alert_policies" {
  description = "The alert policies created."
  value       = google_monitoring_alert_policy.alert_policies
}
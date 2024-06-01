output "notification_channels" {
  description = "The notification channels created."
  value       = google_monitoring_notification_channel.channels
}
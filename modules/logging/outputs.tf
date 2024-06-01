output "log_sinks" {
  description = "The log sinks created."
  value       = google_logging_project_sink.sinks
}
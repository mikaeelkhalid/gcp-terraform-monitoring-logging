# GCP Terraform Monitoring and Logging

This repository provides Terraform modules for setting up alerting, monitoring, logging and dashboarding on Google Cloud Platform (GCP) using Google Cloud Monitoring (formerly Stackdriver). These modules help you getting started to configure logging, monitoring, alerting policies, and dashboards efficiently.

## Table of Contents
- [Introduction](#introduction)
- [Features](#features)
- [Getting Started](#getting-started)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
- [Usage](#usage)
  - [Logging Module](#logging-module)
  - [Monitoring Module](#monitoring-module)
  - [Alerting Policy Module](#alerting-policy-module)
  - [Dashboard Module](#dashboard-module)
  - [Complete Example](#complete-example)
- [Contributing](#contributing)
- [License](#license)

## Introduction

Google Cloud Operations Suite (formerly Stackdriver) offers powerful tools for monitoring and logging your GCP resources. This repository provides reusable Terraform modules that help you configure these tools with minimal effort.

## Features

- **Logging Configuration**: Set up log sinks and exclusions.
- **Monitoring Configuration**: Configure uptime checks and notification channels.
- **Alerting Policies**: Create custom alerting policies based on various metrics.
- **Dashboards**: Set up customizable dashboards for visualizing metrics.

## Getting Started

### Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) 0.13 or later
- A Google Cloud Platform account
- Properly configured [Google Cloud SDK](https://cloud.google.com/sdk/docs/install)

### Installation

1. Clone the repository:
    ```sh
    git clone https://github.com/mikaeelkhalid/gcp-terraform-monitoring-logging.git
    cd gcp-terraform-monitoring-logging
    ```

2. Initialize Terraform:
    ```sh
    terraform init
    ```

## Usage

### Logging Module

#### Variables

| Variable         | Description                                      | Type   | Default |
|------------------|--------------------------------------------------|--------|---------|
| `project_id`     | The ID of the GCP project.                       | string | n/a     |
| `project_region`     | The REGION of the GCP project.                       | string | n/a     |
| `log_sinks`      | List of log sinks to export logs.                | list   | `[]`    |
| `log_exclusions` | List of log exclusions to filter out unwanted logs. | list   | `[]`    |

#### Example

```hcl
module "logging" {
  source = "../modules/logging"

  project_id     = "project-id"
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
```

### Monitoring Module

#### Variables

| Variable         | Description                                      | Type   | Default |
|------------------|--------------------------------------------------|--------|---------|
| `project_id`     | The ID of the GCP project.                       | string | n/a     |
| `project_region`     | The REGION of the GCP project.                       | string | n/a     |
| `uptime_checks`      | List of uptime checks..                | list   | `[]`    |
| `notification_channels` | List of notification channels. | list   | `[]`    |

#### Example

```hcl
module "monitoring" {
  source = "../modules/monitoring"

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
```

### Alerting Module

#### Variables

| Variable         | Description                                      | Type   | Default |
|------------------|--------------------------------------------------|--------|---------|
| `project_id`     | The ID of the GCP project.                       | string | n/a     |
| `project_region`     | The REGION of the GCP project.                       | string | n/a     |
| `alert_policies`      | List of alert policies.               | list   | `[]`    |

#### Example

```hcl
module "alerting_policy" {
  source = "../modules/alerting"

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
```

### Dashboard Module

#### Variables

| Variable         | Description                                      | Type   | Default |
|------------------|--------------------------------------------------|--------|---------|
| `project_id`     | The ID of the GCP project.                       | string | n/a     |
| `project_region`     | The REGION of the GCP project.                       | string | n/a     |
| `dashboards`      | List of dashboards with JSON layout.               | list   | `[]`    |

#### Example

```hcl
module "dashboard" {
  source = "../modules/dashboard"

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
```

### Complete Example

```hcl
module "logging" {
  source = "../modules/logging"

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
  source = "../modules/monitoring"

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
  source = "../modules/alerting"

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
  source = "../modules/dashboard"

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
```

## Contributing

We welcome contributions to this project! Please see [CONTRIBUTING.md](#CONTRIBUTING.md) for details on how to get started.

## License

This project is licensed under the MIT License - see the [LICENSE](#LICENSE) file for details.

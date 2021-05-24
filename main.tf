resource "google_bigquery_dataset" "sensor" {
  dataset_id                  = "sensor"
  friendly_name               = "sensor naes"
  description                 = "Contains measurements from sensors"
  location                    = "EU"

  access {
    role          = "OWNER"
    special_group = "projectOwners"
  }

  access {
    role          = "WRITER"
    user_by_email = google_service_account.sensor-data-provider.email
  }
}

resource "google_service_account" "sensor-data-provider" {
  account_id   = "sensor-data-provider"
  display_name = "Service account used by the code on Raspbery PI"
}

resource "google_service_account_key" "raspberry-pi" {
  service_account_id = google_service_account.sensor-data-provider.id
}

resource "google_bigquery_table" "measurement" {
  dataset_id = google_bigquery_dataset.sensor.dataset_id
  table_id   = "measurement"

  time_partitioning {
    type = "DAY"
    field = "time"
  }

  schema = <<EOF
[
  {
    "name": "time",
    "type": "TIMESTAMP",
    "mode": "REQUIRED"
  },
  {
    "name": "pm25",
    "type": "FLOAT",
    "mode": "REQUIRED"
  },
  {
    "name": "pm10",
    "type": "FLOAT",
    "mode": "REQUIRED"
  },
  {
    "name": "temperature",
    "type": "FLOAT",
    "mode": "REQUIRED"
  }
]
EOF

}


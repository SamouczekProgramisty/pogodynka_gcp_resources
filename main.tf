resource "google_bigquery_dataset" "sensor" {
  dataset_id                  = "sensor"
  friendly_name               = "sensor naes"
  description                 = "Contains measurements from sensors"
  location                    = "EU"

  access {
    role          = "WRITER"
    user_by_email = google_service_account.raspberry-pi.email
  }
}

resource "google_service_account" "raspberry-pi" {
  account_id   = "raspberry-pi"
  display_name = "Service account used by code on Raspbery PI"
}

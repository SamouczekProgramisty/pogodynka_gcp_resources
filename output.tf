output "service_account_keys" {
  value = {
    raspberry-pi = google_service_account_key.raspberry-pi.private_key
  }

  sensitive = true
}

terraform {
  backend "gcs" {
    bucket = "sp-terraform-backend"
    prefix = "/projects/sp-pogodynka/terraform.tfstate"
  }
}

terraform {
  backend "gcs" {
  }
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "5.35.0"
    }
  }
}


provider "google" {
  project = var.project_id
  region  = var.region
}

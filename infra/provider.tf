terraform {
  backend "gcs" {
    bucket = "dynamic-parity-426014-s3-tf-state"
    prefix = "testbranch-tfstate"
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

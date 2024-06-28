resource "google_service_account" "app_svc_acc" {
  account_id   = var.app_svc_acc_name
  display_name = var.app_svc_acc_name
}

resource "google_project_iam_binding" "artifactregistry_admin_binding" {
  project = var.project_id
  role    = "roles/artifactregistry.admin"
  members = [
    "serviceAccount:${google_service_account.app_svc_acc.email}",
  ]
}

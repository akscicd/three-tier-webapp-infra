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

resource "google_project_iam_binding" "editor_binding" {
  project = var.project_id
  role    = "roles/editor"

  members = [
    "serviceAccount:${google_service_account.app_svc_acc.email}",
  ]
}

resource "google_project_iam_binding" "iam_admin_binding" {
  project = var.project_id
  role    = "roles/resourcemanager.projectIamAdmin"

  members = [
    "serviceAccount:${google_service_account.app_svc_acc.email}",
  ]
}

resource "google_project_iam_binding" "compute_admin_binding" {
  project = var.project_id
  role    = "roles/compute.admin"

  members = [
    "serviceAccount:${google_service_account.app_svc_acc.email}",
  ]
}

resource "google_service_account_iam_binding" "user_sa_access" {
  service_account_id = google_service_account.app_svc_acc.name
  role               = "roles/iam.serviceAccountUser"

  members = [
    "user:amit.stp2001@gmail.com",
  ]
}

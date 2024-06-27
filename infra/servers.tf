resource "google_compute_instance" "app-server" {
    name = var.app-server-name
    zone = "europe-west1-b"
    machine_type = "e2-medium"
    
    boot_disk {
      initialize_params {
        image = "projects/ubuntu-os-cloud/global/images/ubuntu-2004-focal-v20240614"
      }
    }
    network_interface {
      subnetwork = google_compute_subnetwork.subnet_private.self_link
    }
    metadata_startup_script = "#!/bin/bash"
}

resource "google_compute_instance" "web-server" {
    name = var.web-server-name
    zone = "europe-west1-b"
    machine_type = "e2-medium"

    boot_disk {
      initialize_params {
        image = "projects/ubuntu-os-cloud/global/images/ubuntu-2004-focal-v20240614"
      }
    }
    network_interface {
      subnetwork = google_compute_subnetwork.subnet_public.self_link
      access_config {
        
      }
    }
    tags = ["http-server"]
    metadata_startup_script = "#!/bin/bash"
}

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
    metadata_startup_script = <<-EOF
    #!/bin/bash
    sudo apt-get update
    sudo apt-get install docker.io -y
    sudo docker pull europe-west1-docker.pkg.dev/dynamic-parity-426014-s3/akscicdprivate/backend:latest
    sudo docker run -itd -p 80:80 europe-west1-docker.pkg.dev/dynamic-parity-426014-s3/akscicdprivate/backend:latest
    EOF
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
    metadata_startup_script = <<-EOF
    #!/bin/bash
    sudo apt-get update
    sudo apt-get install docker.io -y
    sudo docker pull europe-west1-docker.pkg.dev/dynamic-parity-426014-s3/akscicdprivate/frontend:latest
    sudo docker run -itd -p 80:80 europe-west1-docker.pkg.dev/dynamic-parity-426014-s3/akscicdprivate/frontend:latest
    EOF
}

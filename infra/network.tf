resource "google_compute_network" "vpc" {
  name = var.network_name
  auto_create_subnetworks = false
  project = var.project_id
}

resource "google_compute_subnetwork" "subnet_public" {
  name = var.subnet_public
  ip_cidr_range = "10.0.1.0/24"
  region = var.region
  network = google_compute_network.vpc.self_link
}

resource "google_compute_subnetwork" "subnet_private" {
  name = var.subnet_private
  ip_cidr_range = "10.0.2.0/24"
  region = var.region
  network = google_compute_network.vpc.self_link
}

resource "google_compute_firewall" "allow-all-ingress" {
    name = "allow-all-ingress"
    network = google_compute_network.vpc.self_link
    allow {
      protocol = "all"
    }
    source_ranges = ["0.0.0.0/0"]
    direction = "INGRESS"
  
}

resource "google_compute_router" "nat_router" {
  name    = "${google_compute_network.vpc.name}-gw-router"
  network = google_compute_network.vpc.self_link
  region  = var.region
  bgp {
    asn = 64514
  }
}

resource "google_compute_router_nat" "nat_gateway" {
  name = "${google_compute_network.vpc.name}-gw"
  router = google_compute_router.nat_router.name
  region = google_compute_router.nat_router.region
  nat_ip_allocate_option = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}

resource "google_compute_global_address" "private-services-access-ip-ranges" {
  name          = "private-services-access-ip-ranges0001"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = google_compute_network.vpc.self_link
}


resource "google_service_networking_connection" "creating-connection-to-gcp-service" {
  network                 = google_compute_network.vpc.self_link
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private-services-access-ip-ranges.name]
}

output "app_server_private_ip" {
  value = google_compute_instance.app-server.network_interface[0].network_ip
}

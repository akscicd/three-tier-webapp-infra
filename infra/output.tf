output "db-host-ip" {
    value = google_sql_database_instance.db-instance.ip_address.0.ip_address
}
output "app_server_private_ip" {
  value = google_compute_instance.app-server.network_interface[0].network_ip
}

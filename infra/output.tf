output "db-host-ip" {
    value = google_sql_database_instance.db-instance.ip_address.0.ip_address
}

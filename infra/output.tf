output "db-host-ip" {
    value = google_sql_database_instance.database1.ip_address
}
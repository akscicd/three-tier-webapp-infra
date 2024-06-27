resource "google_sql_database_instance" "db-instance" {
    name = var.db-instance
    root_password = var.dbpass
    database_version = "MYSQL_8_0"
    region = var.region
    project = var.project_id
    settings {
        tier = "db-f1-micro"
        availability_type = "ZONAL"
        edition = "ENTERPRISE"
        disk_autoresize = true
        disk_autoresize_limit = 50
        disk_size             = 10
        disk_type             = "PD_SSD"
        user_labels = {
            "tier" = "3"
        }
        
        ip_configuration {
            ipv4ipv4_enabled = false
            private_network = google_compute_network.vpc.self_link
        }
    }
    deletion_protection = false
    depends_on = [ google_service_networking_connection.creating-connection-to-gcp-service ]
}
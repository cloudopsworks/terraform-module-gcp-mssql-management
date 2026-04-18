##
# (c) 2021-2026
#     Cloud Ops Works LLC - https://cloudops.works/
#     Find us on:
#       GitHub: https://github.com/cloudopsworks
#       WebSite: https://cloudops.works
#     Distributed Under Apache v2.0 License
#

output "users" {
  description = "Map of created SQL Server logins with their GCP Secret Manager secret IDs."
  value = {
    for k, user in var.users : k => {
      name      = user.name
      grant     = user.grant
      secret_id = google_secret_manager_secret.user[k].id
    }
  }
}

output "databases" {
  description = "Databases map input reference (SQL Server databases are managed separately via mssql provider)."
  value       = { for k, db in var.databases : k => { name = db.name } }
}

##
# (c) 2021-2026
#     Cloud Ops Works LLC - https://cloudops.works/
#     Find us on:
#       GitHub: https://github.com/cloudopsworks
#       WebSite: https://cloudops.works
#     Distributed Under Apache v2.0 License
#

locals {
  base_users = merge(
    # Database owner logins (one per database with create_owner=true)
    {
      for k, db in var.databases : "${k}_owner" => {
        name         = try(db.owner, "${db.name}_owner")
        databases    = [db.name]
        roles        = ["db_owner"]
        create_login = true
      } if try(db.create_owner, false)
    },
    # Regular users from var.users (all get SQL Server logins in GCP MSSQL)
    {
      for k, user in var.users : k => merge(user, {
        create_login = true
        databases    = [try(user.db_ref, "") != "" ? var.databases[user.db_ref].name : try(user.database_name, "")]
      })
    }
  )
}

module "db" {
  source    = "git::https://github.com/cloudopsworks/terraform-module-mssql-management.git?ref=v1.0.0"
  providers = { mssql = mssql }

  org        = var.org
  is_hub     = var.is_hub
  spoke_def  = var.spoke_def
  extra_tags = var.extra_tags

  users                    = local.base_users
  databases                = var.databases
  server_host              = local.mssql_conn.host
  server_port              = local.mssql_conn.port
  password_rotation_period = var.password_rotation_period
  force_reset              = var.force_reset
}

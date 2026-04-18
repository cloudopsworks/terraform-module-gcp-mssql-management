##
# (c) 2021-2026
#     Cloud Ops Works LLC - https://cloudops.works/
#     Find us on:
#       GitHub: https://github.com/cloudopsworks
#       WebSite: https://cloudops.works
#     Distributed Under Apache v2.0 License
#

provider "mssql" {
  hostname = local.mssql_conn.host
  port     = local.mssql_conn.port
  sql_auth {
    username = local.mssql_conn.username
    password = local.mssql_conn.password
  }
}

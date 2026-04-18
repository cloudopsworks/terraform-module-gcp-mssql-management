##
# (c) 2021-2026
#     Cloud Ops Works LLC - https://cloudops.works/
#     Find us on:
#       GitHub: https://github.com/cloudopsworks
#       WebSite: https://cloudops.works
#     Distributed Under Apache v2.0 License
#

resource "random_password" "user" {
  for_each         = var.users
  length           = 20
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
  min_lower        = 2
  min_upper        = 2
  min_numeric      = 2
  min_special      = 2
}

resource "mssql_login" "user" {
  for_each                  = var.users
  server_login              = each.value.name
  login_password            = random_password.user[each.key].result
  default_language          = try(each.value.default_language, "us_english")
  check_password_expiration = try(each.value.check_password_expiration, false)
  check_password_policy     = try(each.value.check_password_policy, true)
  must_change_password      = try(each.value.must_change_password, false)
}

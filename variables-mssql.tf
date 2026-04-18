##
# (c) 2021-2026
#     Cloud Ops Works LLC - https://cloudops.works/
#     Find us on:
#       GitHub: https://github.com/cloudopsworks
#       WebSite: https://cloudops.works
#     Distributed Under Apache v2.0 License
#

## users:
#   <user_ref>:
#     name: "username"                   # (Required) SQL Server login name.
#     grant: "owner"                     # (Required) owner, readwrite, readonly.
#     db_ref: "db_ref"                   # (Optional) Reference to databases key.
#     database_name: "dbname"            # (Optional) Database name when db_ref not set.
#     default_language: "us_english"     # (Optional) Default: us_english.
#     check_password_expiration: false   # (Optional) Default: false.
#     check_password_policy: true        # (Optional) Default: true.
#     must_change_password: false        # (Optional) Default: false.
#     import: false                      # (Optional) Default: false.
#     hoop:
#       access_control: []
variable "users" {
  description = "Map of SQL Server logins — see inline docs."
  type        = any
  default     = {}
}

## databases:
#   <db_ref>:
#     name: "dbname"                     # (Required) Database name.
#     create_owner: false                # (Optional) Create owner login. Default: false.
#     owner: "ownername"                 # (Optional) Owner login name.
#     default_collation: "SQL_Latin1_General_CP1_CI_AS"
#     default_language: "us_english"
#     check_password_expiration: false
#     check_password_policy: true
#     must_change_password: false
variable "databases" {
  description = "Map of SQL Server databases — see inline docs."
  type        = any
  default     = {}
}

## hoop:
#   enabled: false
#   agent_id: ""
#   community: true
#   import: false
#   tags: {}
#   access_control: []
variable "hoop" {
  description = "Hoop connection settings."
  type        = any
  default     = {}
}

## cloudsql:
#   enabled: false
#   instance_name: ""
#   project_id: ""
#   from_secret: false
#   secret_id: ""
#   server_name: ""
#   admin_username: "sqladmin"
#   admin_password: ""
#   db_name: "master"
variable "cloudsql" {
  description = "Cloud SQL MSSQL instance connection."
  type        = any
  default     = {}
}

## direct:
#   server_name: ""
#   host: ""
#   port: 1433
#   username: ""
#   password: ""
#   db_name: "master"
variable "direct" {
  description = "Direct MSSQL connection."
  type        = any
  default     = {}
}

variable "password_rotation_period" {
  description = "(Optional) Password rotation period in days. Default: 90."
  type        = number
  default     = 90
}

variable "force_reset" {
  description = "(Optional) Force reset passwords. Default: false."
  type        = bool
  default     = false
}

variable "secrets_kms_key_name" {
  description = "(Optional) GCP KMS key name for encrypting secrets."
  type        = string
  default     = null
}

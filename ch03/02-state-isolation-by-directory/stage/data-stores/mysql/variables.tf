variable "db_username" {
  description = "Username for database"
  type        = string
  sensitive   = true
}

variable "db_password" {
  description = "Password for database"
  type        = string
  sensitive   = true
}

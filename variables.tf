variable "db_name" {
  description = "Name of the Laravel MySQL database"
  type        = string
  sensitive   = true
}

variable "db_user" {
  description = "MySQL username"
  type        = string
  sensitive   = true
}

variable "db_pass" {
  description = "MySQL password"
  type        = string
  sensitive   = true
}

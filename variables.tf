variable "office_ip" {
  description = "Your office IP address with CIDR block (e.g., 203.0.113.10/32)"
  type        = string
}
variable "aws_instance_type_t2micro" {
  default     = "t2.micro"
  description = "Default EC2 instance type"
}

variable "aws_availability_zone_a" {
  default     = "eu-central-1a"
  description = "Primary AZ"
}

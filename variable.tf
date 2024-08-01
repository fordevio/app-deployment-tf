/*
Input variables for infrastructure
*/

variable "private_ec2_instance_type" {
  type        = string
  default     = "t2.micro"
  description = "value of the instance type for private instances"
}

variable "public_ec2_instance_type" {
  type        = string
  default     = "t2.micro"
  description = "value of the instance type for public instances"
}

variable "key_name" {
  type        = string
  description = "value of the key name for the instances"
}
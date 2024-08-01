/*
Input variables for infrastructure
*/

variable "private_ec2_instance_type" {
    type = string
    default = "t2.micro"
}

variable "public_ec2_instance_type" {
    type = string
    default = "t2.micro"
}

variable "key_name" {
    type = string
  
}
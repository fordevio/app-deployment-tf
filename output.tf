/*
Outputs of the terraform script
*/

output "public_ip_ec2_a" {
  value = aws_instance.public_instance_a.public_ip
  description = "Public IP address of public instance A"
  
}

output "public_ip_ec2_b" {
  value = aws_instance.public_instance_b.public_ip
  description = "Public IP address of public instance b"
  
}

output "alb_dns" {
  value = aws_lb.aws_lb.dns_name
  description = "DNS name of the Application Load Balancer"
  
}


terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "ap-south-1"
}


# Create a VPC
resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
  tags = {
    Name = "main"
  }

}










# create eips
resource "aws_eip" "nat_eip_a" {
  vpc = true
  tags = {
    Name = "nat_eip_a"
  }
}

resource "aws_eip" "nat_eip_b" {
  vpc = true
  tags = {
    Name = "nat_eip_b"}
}

# Create nat gateways
resource "aws_nat_gateway" "nat_gw_a" {
  allocation_id = aws_eip.nat_eip_a.id
  subnet_id     = aws_subnet.public_a.id
  tags = {
    Name = "nat_gw_a"
  } 
}

resource "aws_nat_gateway" "nat_gw_b" {
  allocation_id = aws_eip.nat_eip_b.id
  subnet_id     = aws_subnet.public_b.id
  tags = {
    Name = "nat_gw_b"
  } 
}



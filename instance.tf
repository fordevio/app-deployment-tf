
// ec2 instance AMI
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}


// Create ec2 instances
resource "aws_instance" "public_instance_a" {
  ami             = data.aws_ami.ubuntu.id
  instance_type   = var.public_ec2_instance_type
  subnet_id       = aws_subnet.public_a.id
  security_groups = [aws_security_group.public_sg.id]
  key_name        = var.key_name


  tags = {
    Name = "public_instance_a"
  }
}

resource "aws_instance" "public_instance_b" {
  ami             = data.aws_ami.ubuntu.id
  instance_type   = var.public_ec2_instance_type
  subnet_id       = aws_subnet.public_b.id
  security_groups = [aws_security_group.public_sg.id]
  key_name        = var.key_name
  tags = {
    Name = "public_instance_b"
  }
}

resource "aws_instance" "private_instance_a" {
  ami             = data.aws_ami.ubuntu.id
  instance_type   = var.private_ec2_instance_type
  subnet_id       = aws_subnet.private_a.id
  security_groups = [aws_security_group.sg_private.id]
  key_name        = "newKey"
  user_data       = <<-EOF
              #!/bin/bash
              apt-get update
              apt-get install -y nginx
              systemctl start nginx
              systemctl enable nginx
              EOF


  tags = {
    Name = "private_instance_a"
  }
}

resource "aws_instance" "private_instance_b" {
  ami             = data.aws_ami.ubuntu.id
  instance_type   = var.private_ec2_instance_type
  security_groups = [aws_security_group.sg_private.id]
  subnet_id       = aws_subnet.private_b.id
  key_name        = var.key_name
  user_data       = <<-EOF
              #!/bin/bash
              apt-get update
              apt-get install -y nginx
              systemctl start nginx
              systemctl enable nginx
              EOF


  tags = {
    Name = "private_instance_b"
  }
}
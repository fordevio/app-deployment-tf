
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
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public_a.id
  key_name      = "newKey"
  tags = {
    Name = "public_instance_a"
  }
}

resource "aws_instance" "public_instance_b" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public_b.id
  key_name      = "newKey"
  tags = {
    Name = "public_instance_b"
  }
}

resource "aws_instance" "private_instance_a" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.private_a.id
  key_name      = "newKey"
  tags = {
    Name = "private_instance_a"
  }
}

resource "aws_instance" "private_instance_b" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.private_b.id
  key_name      = "newKey"
  tags = {
    Name = "private_instance_b"
  }
}
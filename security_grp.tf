// Security group for alb
resource "aws_security_group" "alb_sg" {
  vpc_id      = aws_vpc.main.id
  description = "Allow inbound and outbound trraffic for alb"
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


// Sedurity group for public instances
resource "aws_security_group" "public_sg" {
  vpc_id      = aws_vpc.main.id
  description = "Allow inbound and outbound trraffic for private ec2"


  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "sg_private" {
  vpc_id      = aws_vpc.main.id
  description = "Allow inbound and outbound traffic for public instances"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group_rule" "sgr_private_ssh" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  security_group_id        = aws_security_group.sg_private.id
  source_security_group_id = aws_security_group.public_sg.id
}

resource "aws_security_group_rule" "sgr_private_http" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  security_group_id        = aws_security_group.sg_private.id
  source_security_group_id = aws_security_group.alb_sg.id
}
# Create a route table
resource "aws_route_table" "rtable" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
  tags = {
    Name = "main"
  }
}

# Create a route table for private subnets
resource "aws_route_table" "private_rtable_a" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat_gw_a.id
  }
}

resource "aws_route_table" "private_rtable_b" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat_gw_b.id
  }
}


# Associate the route table with internet gateway
resource "aws_route_table_association" "rt_gw_access" {
  gateway_id     = aws_internet_gateway.gw.id
  route_table_id = aws_route_table.rtable.id
}

# Associate the route table with subnet
resource "aws_route_table_association" "rt_subnet_a" {
  subnet_id      = aws_subnet.public_a.id
  route_table_id = aws_route_table.rtable.id
}

resource "aws_route_table_association" "rt_subnet_b" {
  subnet_id      = aws_subnet.public_b.id
  route_table_id = aws_route_table.rtable.id
}

# Associate the route table with private subnets
resource "aws_route_table_association" "private_rt_subnet_a" {
  subnet_id      = aws_subnet.private_a.id
  route_table_id = aws_route_table.private_rtable_a.id
}

resource "aws_route_table_association" "private_rt_subnet_b" {
  subnet_id      = aws_subnet.private_b.id
  route_table_id = aws_route_table.private_rtable_b.id
}



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
  Name = "nat_eip_b" }
}



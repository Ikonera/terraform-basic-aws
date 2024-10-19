resource "aws_internet_gateway" "my_igw" {
  vpc_id = var.vpc_id
  tags = {
    Name = "My Internet Gateway"
  }
}

resource "aws_eip" "my_eip" {
  depends_on = [aws_internet_gateway.my_igw]
  tags = {
    Name = "My EIP"
  }
}

resource "aws_nat_gateway" "my_nat" {
  allocation_id = aws_eip.my_eip.id
  subnet_id     = var.public_subnet_ids[0]
  tags = {
    Name = "My NAT Gateway"
  }
  depends_on = [aws_internet_gateway.my_igw]
}

resource "aws_internet_gateway" "my_igw" {
  vpc_id = var.vpc_id
  tags = {
    Name = "My Internet Gateway"
  }
}

resource "aws_eip" "my_eip" {
  count      = length(var.private_subnet_ids)
  depends_on = [aws_internet_gateway.my_igw]
  tags = {
    Name = "Elastic IP ${count.index + 1}"
  }
}

resource "aws_nat_gateway" "my_nat" {
  count         = length(var.public_subnet_ids)
  allocation_id = element(aws_eip.my_eip.*.id, count.index)
  subnet_id     = element(var.public_subnet_ids, count.index)
  tags = {
    Name = "NAT Gateway ${count.index + 1}"
  }
  depends_on = [aws_internet_gateway.my_igw]
}

resource "aws_subnet" "public_subnet" {
  count             = var.public_subnet_count
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = element(var.public_subnets, count.index)
  availability_zone = element(var.availability_zones, count.index)
  tags = {
    Name = "Public subnet ${count.index + 1}"
  }
}

resource "aws_subnet" "private_subnet" {
  count             = var.private_subnet_count
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = element(var.private_subnets, count.index)
  availability_zone = element(var.availability_zones, count.index)
  tags = {
    Name = "Private subnet ${count.index + 1}"
  }
}


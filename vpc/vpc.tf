resource "aws_vpc" "my_vpc" {
  cidr_block = var.vpc_cidr
  tags       = var.tags
}

resource "aws_subnet" "public_subnet" {
  vpc_id            = aws_vpc.my_vpc.id
  count             = var.public_subnet_count
  cidr_block        = element(var.public_subnets, count.index)
  availability_zone = element(var.availability_zones, count.index)
  tags = {
    Name    = "Public subnet ${count.index + 1}"
    Project = "Athoria"
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.my_vpc.id
  count             = var.private_subnet_count
  cidr_block        = element(var.private_subnets, count.index)
  availability_zone = element(var.availability_zones, count.index)
  tags = {
    Name    = "Private subnet ${count.index + 1}"
    Project = "Athoria"
  }
}

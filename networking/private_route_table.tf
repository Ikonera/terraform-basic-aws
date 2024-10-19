resource "aws_route_table" "private_route_table" {
  count  = length(var.private_subnet_ids)
  vpc_id = var.vpc_id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = element(aws_nat_gateway.my_nat[*].id, count.index)
  }
  tags = {
    Name = "Private RT ${count.index + 1}"
  }
}

resource "aws_route_table_association" "private_route_table_association" {
  count          = length(var.private_subnet_ids)
  subnet_id      = element(var.private_subnet_ids, count.index)
  route_table_id = aws_route_table.private_route_table[count.index].id
}

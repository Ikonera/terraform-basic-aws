resource "aws_security_group" "lb_security_group" {
  vpc_id = var.vpc_id
  tags = {
    Name = "Load Balancer Security Group"
  }
}

resource "aws_security_group_rule" "lb_http_ingress" {
  security_group_id = aws_security_group.lb_security_group.id
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "lb_https_ingress" {
  security_group_id = aws_security_group.lb_security_group.id
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "lb_instance_egress" {
  security_group_id = aws_security_group.lb_security_group.id
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group" "instance_security_group" {
  vpc_id = var.vpc_id
  tags = {
    Name = "Instance Security Group"
  }
}

resource "aws_security_group_rule" "instance_http_ingress" {
  security_group_id        = aws_security_group.instance_security_group.id
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.lb_security_group.id
}

resource "aws_security_group_rule" "instance_https_ingress" {
  security_group_id        = aws_security_group.instance_security_group.id
  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.lb_security_group.id
}

resource "aws_security_group_rule" "instance_traffic_egress" {
  security_group_id = aws_security_group.instance_security_group.id
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

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

resource "aws_route_table" "public_route_table" {
  vpc_id = var.vpc_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id
  }
  tags = {
    Name = "Public route table"
  }
}

resource "aws_route_table" "private_route_table" {
  vpc_id = var.vpc_id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.my_nat.id
  }
  tags = {
    Name = "Private route table"
  }
}

resource "aws_route_table_association" "public_route_table_association" {
  count          = length(var.public_subnet_ids)
  subnet_id      = element(var.public_subnet_ids, count.index)
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "private_route_table_association" {
  count          = length(var.private_subnet_ids)
  subnet_id      = element(var.private_subnet_ids, count.index)
  route_table_id = aws_route_table.private_route_table.id
}

resource "aws_lb" "my_lb" {
  name                       = var.lb_name
  internal                   = false
  load_balancer_type         = "application"
  subnets                    = var.public_subnet_ids
  security_groups            = var.lb_security_group_ids
  enable_deletion_protection = false
  tags = {
    Name = "My Load Balancer"
  }
}

resource "aws_lb_target_group" "lb_http_target_group" {
  vpc_id   = var.vpc_id
  name     = "my-http-target-group"
  protocol = "HTTP"
  port     = 80
  tags = {
    Name = "My HTTP Target Group"
  }
}

resource "aws_lb_target_group" "lb_https_target_group" {
  vpc_id   = var.vpc_id
  name     = "my-https-target-group"
  protocol = "HTTPS"
  port     = 443
  tags = {
    Name = "My HTTPS Target Group"
  }
}

resource "aws_lb_target_group_attachment" "lb_target_group_http_attachment" {
  count            = length(var.instance_ids_to_attach)
  target_group_arn = aws_lb_target_group.lb_http_target_group.arn
  target_id        = element(var.instance_ids_to_attach, count.index)
  port             = 80
}

resource "aws_lb_target_group_attachment" "lb_target_group_https_attachment" {
  count            = length(var.instance_ids_to_attach)
  target_group_arn = aws_lb_target_group.lb_https_target_group.arn
  target_id        = element(var.instance_ids_to_attach, count.index)
  port             = 443
}

resource "aws_lb_listener" "lb_http_listener" {
  load_balancer_arn = aws_lb.my_lb.arn
  port              = 80
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lb_http_target_group.arn
  }
}

resource "aws_lb_listener" "lb_https_listener" {
  load_balancer_arn = aws_lb.my_lb.arn
  port              = 443
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lb_https_target_group.arn
  }
}

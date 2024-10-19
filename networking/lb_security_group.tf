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

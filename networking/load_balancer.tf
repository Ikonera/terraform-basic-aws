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

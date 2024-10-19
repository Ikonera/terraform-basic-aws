resource "aws_placement_group" "placement_group" {
  name     = var.placement_group_name
  strategy = var.placement_group_strategy
}

resource "aws_autoscaling_group" "scaling_group" {
  min_size         = var.min_size
  max_size         = var.max_size
  desired_capacity = var.desired_capacity
  name             = "nginx_scg"

  placement_group = aws_placement_group.placement_group.name
  launch_template {
    id      = aws_launch_template.launch_template.id
    version = "$Latest"
  }
  vpc_zone_identifier = var.private_subnet_ids
}

resource "aws_autoscaling_attachment" "http_autoscaling_attachment" {
  autoscaling_group_name = aws_autoscaling_group.scaling_group.name
  lb_target_group_arn    = var.lb_http_target_group_arn
}

resource "aws_autoscaling_attachment" "https_autoscaling_attachment" {
  autoscaling_group_name = aws_autoscaling_group.scaling_group.name
  lb_target_group_arn    = var.lb_https_target_group_arn
}

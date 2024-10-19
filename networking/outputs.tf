output "lb_security_group_id" {
  value = aws_security_group.lb_security_group.id
}

output "instance_security_group_id" {
  value = aws_security_group.instance_security_group.id
}

output "lb_http_target_group_arn" {
  value = aws_lb_target_group.lb_http_target_group.arn
}

output "lb_https_target_group_arn" {
  value = aws_lb_target_group.lb_https_target_group.arn
}

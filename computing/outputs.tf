output "launch_template_name" {
  value = aws_launch_template.launch_template.name
}

output "instance_ids" {
  value = data.aws_instances.instance_ids.ids
}

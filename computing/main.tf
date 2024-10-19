resource "aws_launch_template" "launch_template" {
  name_prefix            = "launch_template"
  image_id               = var.ami
  instance_type          = var.instance_type
  user_data              = filebase64("${path.module}/user_data.sh")
  vpc_security_group_ids = var.security_group_ids
  tag_specifications {
    resource_type = "instance"
    tags = {
      ManagedBy = "ASG"
    }
  }
}

data "aws_instances" "instance_ids" {
  instance_tags = {
    ManagedBy = "ASG"
  }
}

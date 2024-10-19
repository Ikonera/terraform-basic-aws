variable "security_group_ids" {
  description = "The IDs of the security groups"
  type        = list(string)
  nullable    = false
}

variable "private_subnet_ids" {
  description = "The IDs of the private subnets"
  type        = list(string)
  nullable    = false
}

variable "instance_type" {
  description = "The type of instance to start"
  default     = "t3.micro"
  type        = string
}

variable "ami" {
  description = "The AMI to use for the instance"
  type        = string
  default     = "ami-01c5300f289d64643"
}

variable "vpc_id" {
  description = "The VPC ID"
  type        = string
  nullable    = false
}

variable "min_size" {
  description = "The minimum number of instances in the autoscaling group"
  type        = number
  default     = 2
}

variable "max_size" {
  description = "The maximum number of instances in the autoscaling group"
  type        = number
  default     = 2
}

variable "desired_capacity" {
  description = "The desired number of instances in the autoscaling group"
  type        = number
  default     = 2
}

variable "scaling_group_name" {
  description = "The name of the scaling group"
  type        = string
  default     = "scaling_group"
}

variable "placement_group_name" {
  description = "The name of the placement group"
  type        = string
  default     = "placement_group"
}

variable "placement_group_strategy" {
  description = "The strategy of the placement group"
  type        = string
  default     = "spread"
}

variable "lb_http_target_group_arn" {
  description = "The ARN of the HTTP target group"
  type        = string
  nullable    = false
}

variable "lb_https_target_group_arn" {
  description = "The ARN of the HTTPS target group"
  type        = string
  nullable    = false
}

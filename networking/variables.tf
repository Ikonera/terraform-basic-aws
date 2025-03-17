variable "tags" {
  type = map(string)
  default = {
    "Project" = "terraform-basic-aws"
  }
}

variable "lb_name" {
  type        = string
  description = "The name of the load balancer"
  default     = "MyLoadBalancer"
}

variable "vpc_id" {
  description = "The VPC ID"
  type        = string
  nullable    = false
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
  nullable    = false
}

variable "public_subnet_ids" {
  type        = list(string)
  description = "The IDs of the public subnets"
  nullable    = false
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "The IDs of the private subnets"
  nullable    = false
}

variable "private_subnet_cidrs" {
  type        = list(string)
  description = "The CIDR blocks for the private subnets"
  nullable    = false
}

variable "lb_security_group_ids" {
  type        = list(string)
  description = "The IDs of the lb security groups"
  nullable    = false
}

variable "instance_ids_to_attach" {
  type        = list(string)
  description = "The IDs of the instances to attach to the target group"
  nullable    = false
}

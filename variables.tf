variable "availability_zones" {
  type        = list(string)
  description = "The availability zones for the subnets"
  default     = ["eu-west-3a", "eu-west-3b"]
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "172.16.0.0/24"
  nullable    = false
}

variable "public_subnet_cidrs" {
  type        = list(string)
  description = "The CIDR blocks for the public subnets"
  default     = ["172.16.0.0/26", "172.16.0.64/26"]
  nullable    = false
}

variable "private_subnet_cidrs" {
  type        = list(string)
  description = "The CIDR blocks for the public subnets"
  default     = ["172.16.0.128/26", "172.16.0.192/26"]
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
  default     = "ami-00d81861317c2cc1f"
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
  nullable    = false
}

variable "public_subnet_count" {
  description = "The number of public subnets"
  type        = number
  default     = 2
}

variable "private_subnet_count" {
  description = "The number of private subnets"
  type        = number
  default     = 2
}

variable "public_subnets" {
  description = "The CIDR blocks for the public subnets"
  type        = list(string)
  nullable    = false
}

variable "private_subnets" {
  description = "The CIDR blocks for the private subnets"
  type        = list(string)
  nullable    = false
}

variable "availability_zones" {
  description = "The availability zones for the subnets"
  type        = list(string)
  nullable    = false
}

variable "tags" {
  description = "The tags to apply to the resources"
  type        = map(string)
  default = {
    Project = "Athoria"
  }
}

module "vpc" {
  source             = "./vpc"
  vpc_cidr           = var.vpc_cidr
  public_subnets     = var.public_subnet_cidrs
  private_subnets    = var.private_subnet_cidrs
  availability_zones = var.availability_zones
}

module "computing" {
  source                    = "./computing"
  vpc_id                    = module.vpc.vpc_id
  instance_type             = var.instance_type
  ami                       = var.ami
  private_subnet_ids        = module.vpc.private_subnet_ids
  security_group_ids        = [module.networking.instance_security_group_id]
  lb_http_target_group_arn  = module.networking.lb_http_target_group_arn
  lb_https_target_group_arn = module.networking.lb_https_target_group_arn
}

module "networking" {
  source                 = "./networking"
  vpc_id                 = module.vpc.vpc_id
  vpc_cidr               = var.vpc_cidr
  public_subnet_ids      = module.vpc.public_subnet_ids
  private_subnet_ids     = module.vpc.private_subnet_ids
  private_subnet_cidrs   = var.private_subnet_cidrs
  lb_security_group_ids  = [module.networking.lb_security_group_id]
  instance_ids_to_attach = module.computing.instance_ids
}

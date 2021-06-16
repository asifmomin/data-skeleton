module "personal-infra" {
    source = "../modules/personal_infra_setup"
    vpc_cidr = var.vpc_cidr
    prefix = var.prefix
    private_subnet_cidrs = var.private_subnet_cidrs
    public_subnet_cidrs = var.public_subnet_cidrs
    availability_zones = var.availability_zones
}
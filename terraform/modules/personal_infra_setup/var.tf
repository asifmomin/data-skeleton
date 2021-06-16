variable "vpc_cidr" {}
variable "private_subnet_cidrs" {}
variable "public_subnet_cidrs" {}

variable "availability_zones" {
    default = ""
}

variable "prefix" {
    default = ""
}

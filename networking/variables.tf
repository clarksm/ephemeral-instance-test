#----- networking/variables.tf

variable "vpc_cidr" {}

variable "public_cidrs" {
	type = "list"
}

variable "accessip" {}

variable "prd_vpc_cidr" {}

variable "public_prd_cidrs" {
	type = "list"
}

variable "prd_accessip" {}

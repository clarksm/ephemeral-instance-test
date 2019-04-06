variable "aws_region" {}

#----storage variables
variable "project_name" {}

#----networking variables
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


#----compute variables
variable "key_name" {}

variable "public_key_path" {}

variable "server_instance_type" {}

variable "instance_count" {
	default = 1
}

variable "prd_server_instance_type" {}

variable "prd_instance_count" {
	default = 1
}

#----backend variables
variable "relative_state_path" {}

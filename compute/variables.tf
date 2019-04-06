#----compute/variables.tf

variable "key_name" {}

variable "public_key_path" {}

variable "subnet_ips" {
	type = "list"
}

variable "instance_count" {}

variable "instance_type" {}

variable "security_group" {}

variable "subnets" {
	type = "list"
}

#-----production instance variables
variable "prd_subnet_ips" {
	type = "list"
}
variable "prd_instance_count" {}

variable "prd_instance_type" {}

variable "prd_security_group" {}

variable "prd_subnets" {
	type = "list"
}


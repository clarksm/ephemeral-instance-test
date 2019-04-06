#----networking/outputs.tf

output "public_subnets" {
	value = "${aws_subnet.tf_public_subnet.*.id}"
}

output "public_sg" {
	value = "${aws_security_group.tf_public_sg.id}"	
}

output "subnet_ips" {
	value = "${aws_subnet.tf_public_subnet.*.cidr_block}"
}

output "prd_public_subnets" {
	value = "${aws_subnet.tf_prd_public_subnet.*.id}"
}

output "prd_public_sg" {
	value = "${aws_security_group.tf_prd_public_sg.id}"	
}

output "prd_subnet_ips" {
	value = "${aws_subnet.tf_prd_public_subnet.*.cidr_block}"
}

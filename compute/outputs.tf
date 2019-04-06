#---compute/outputs.tf
output "server_id" {
	value = "${join(", ", aws_instance.tf_server.*.id)}"
}

output "server_ip" {
	value = "${join(", ", aws_instance.tf_server.*.public_ip)}"
}

output "prd_server_id" {
	value = "${join(", ", aws_instance.tf_prd_server.*.id)}"
}

output "prd_server_ip" {
	value = "${join(", ", aws_instance.tf_prd_server.*.public_ip)}"
}

#------ compute/main.tf

data "aws_ami" "server_ami" {
	most_recent = true
	owners 		= ["amazon"]

	filter {
		name 	= "name"
		values 	= ["amzn-ami-hvm*-x86_64-gp2"]
	}
}

resource "aws_key_pair" "tf_auth" {
	key_name 	= "${var.key_name}"
	public_key 	= "${file(var.public_key_path)}"

	#ssh-keygen
}

data "template_file" "user-init" {
	count = 2
	template = "${file("${path.module}/userdata.tpl")}"

	vars {
		firewall_subnets = "${element(var.subnet_ips, count.index)}"
	}
}

resource "aws_instance" "tf_server" {
	count 			= "${var.instance_count}"
	instance_type 	= "${var.instance_type}"
	ami 			= "${data.aws_ami.server_ami.id}"

	tags = {
		Name 		= "tf_server-${count.index +1}"
		Environment	= "Dev"
	}

	key_name = "${aws_key_pair.tf_auth.id}"
	vpc_security_group_ids = ["${var.security_group}"]
	subnet_id = "${element(var.subnets, count.index)}"
	//user_data = "${data.template_file.user-init.*.rendered[count.index]}"

	//provisioner "local-exec" {
	//	command    = "echo ${self.public_ip} >> hosts.txt"
  //}

}

resource "aws_instance" "tf_prd_server" {
	count 			= "${var.prd_instance_count}"
	instance_type 	= "${var.prd_instance_type}"
	ami 			= "${data.aws_ami.server_ami.id}"

	tags = {
		Name 		= "tf_prd_server-${count.index +1}"
		Environment	= "Prod"
	}

	key_name = "${aws_key_pair.tf_auth.id}"
	vpc_security_group_ids = ["${var.prd_security_group}"]
	subnet_id = "${element(var.prd_subnets, count.index)}"
	//user_data = "${data.template_file.user-init.*.rendered[count.index]}"

	//provisioner "local-exec" {
	//	command    = "echo ${self.public_ip} >> hosts.txt"
  //}

}


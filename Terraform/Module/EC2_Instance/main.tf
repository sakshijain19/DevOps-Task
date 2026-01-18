resource "aws_instance" "webserver" {
ami = var.ami_id
instance_type = var.instance_type
key_name = var.key
vpc_security_group_ids = var.sg_id
tags ={
    Name = "${var.project}-instance"
    env = var.env
}
subnet_id = var.subnet_id
}
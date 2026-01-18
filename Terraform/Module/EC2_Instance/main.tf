resource "aws_instance" "webserver" {
ami           = var.ami_id
instance_type = var.instance_type

vpc_security_group_ids = [aws_security_group.web_sg.id]
subnet_id              = var.subnet_id
key_name = var.key
tags = {
    Name = "${var.project}-instance"
env  = var.env
}
}
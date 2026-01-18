resource "aws_instance" "webserver" {
ami           = var.ami_id
instance_type = var.instance_type

vpc_security_group_ids = [var.vpc_id]
key_name = var.key
tags = {
    Name = var.tags
}
}
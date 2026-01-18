terraform {
backend "s3" {
    bucket = "sample001-test"
    key    = "terraform.tfstate"
    region = "us-east-1"
}
}
provider "aws" {
region = "us-east-1"
}
resource "aws_security_group" "web_sg" {
    name   = "web-sg"
    vpc_id = aws_vpc.myvpc.id

ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
}

ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
}

egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
}

tags = {
    Name = "web-sg"
}
}

resource "aws_instance" "webserver" {
ami           = var.ami_id
instance_type = var.instance_type

subnet_id              = module.my_vpc_module.vpc_id
vpc_security_group_ids = [aws_security_group.web_sg.id]

tags = {
    Name = "EC2-inside-VPC"
}


user_data = <<-EOF
#!/bin/bash
apt update -y
apt install apache2 -y
systemctl start apache2
systemctl enable apache2
echo "<h1>Welcome to ExampleInstance</h1>" > /var/www/html/index.html
EOF
depends_on = [ aws_security_group.web_sg ]
}

module "my_vpc_module" {
source = "./Module/VPC"
cidr_block           = var.cidr_block
public_subnet_cidr   = var.public_subnet_cidr
private_subnet_cidr  = var.private_subnet_cidr
}


module "EC2_module" {
source = "./Module/EC2_Instance"
ami_id = var.ami_id
instance_type = var.instance_type
vpc_id = module.my_vpc_module.vpc_id
key = var.key
tags = var.tags
}
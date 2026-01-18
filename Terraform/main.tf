terraform {
backend "s3" {
    bucket = "sample001-test"
    key    = "terraform.tfstate"
    region = "us-east-1"
}
}
provider "aws" {
region = var.region
}
resource "aws_security_group" "web_sg" {
    name   = "web-sg"
    vpc_id = module.my_vpc_module.vpc_id

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
depends_on = [aws_security_group.web_sg]
}

module "my_vpc_module" {
source = "./Module/VPC"
cidr_block = var.cidr_block
public_subnet_cidr = var.public_subnet_cidr
private_subnet_cidr = var.private_subnet_cidr
}

module "EC2_module" {
source = "./Module/EC2_Instance"
ami_id = var.ami_id
instance_type = var.instance_type
subnet_id = module.my_vpc_module.public_subnet_id
vpc_id = module.my_vpc_module.vpc_id
key = var.key
project = var.project
env = var.env
}
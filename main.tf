locals {
  Instance_name = "ExampleInstance"
  region        = "us-east-1"
}

terraform { 
  backend "s3" {
  bucket = "sample001-test"
  key    = "terraform.tfstate"
  region = local.region
}
}

provider "aws" {
  region = local.region 
}
data "aws_ami" "amazon_linux" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["095074107161"] # Amazon
  
}
resource "aws_instance" "ExampleInstance" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = var.instance_type

  subnet_id              = "subnet-0ff35381a830914ad"
  vpc_security_group_ids = ["sg-088e5ceffeadaf431"]  # <-- FIX HERE

  tags = {
    Name = local.Instance_name
  }
}




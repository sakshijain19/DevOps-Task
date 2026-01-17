locals {
  Instance_name = "ExampleInstance"
  region        = "us-east-1"
}

terraform { 
  backend "s3" {
  bucket = "sample001-test"
  key    = "terraform.tfstate"
  region = "us-east-1"
}
}

provider "aws" {
  region = local.region 
}

data "aws_security_group" "mysg" {
  filter {
    name   = "group-name"
    values = ["mysg"]
  }

  filter {
    name   = "vpc-id"
    values = ["vpc-0b5dc84df6efcb6a9"]
  }
}

resource "aws_instance" "ExampleInstance" {
  ami           = var.ami_id
  instance_type = var.instance_type

  subnet_id              = "subnet-0ff35381a830914ad"
  vpc_security_group_ids = [data.aws_security_group.mysg.id]

  tags = {
    Name = local.Instance_name
  }
}




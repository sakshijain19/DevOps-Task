
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

resource "aws_instance" "ExampleInstance" {
  ami           = var.ami_id
  instance_type = var.instance_type

  subnet_id              = "subnet-0ff35381a830914ad"
  vpc_security_group_ids = ["sg-088e5ceffeadaf431"]  # <-- FIX HERE

  tags = {
    Name = "ExampleInstance"
  }
}




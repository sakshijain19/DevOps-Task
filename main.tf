
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
resource "aws_instance" "my_ec2" {
  ami = var.ami_id
  instance_type = var.instance_type

  subnet_id              = "subnet-0ff35381a830914ad"
  vpc_security_group_ids = ["vpc-0b5dc84df6efcb6a9"]

  tags = {
    Name = "ExampleInstance"
  }
}



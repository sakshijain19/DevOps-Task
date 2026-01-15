provider "aws" {
  region = "us-east-1"
}
resource "aws_instance" "example" {
    count = 2
  ami           = "ami-0ecb62995f68bb549"
  instance_type = "t2.micro"
  vpc_security_group_ids = ["sg-088e5ceffeadaf431"]
  
  tags = {
    Name = "ExampleInstance"
  }
}

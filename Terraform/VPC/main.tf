provider "aws" {
region = var.region
}

resource "aws_vpc" "myvpc" {
cidr_block = var.cidr_block
tags = {
    Name = "myvpc"
}
}

resource "aws_subnet" "pvtsubnet" {
vpc_id            = aws_vpc.myvpc.id
availability_zone = "us-east-1a"
cidr_block        = var.private_subnet_cidr
map_public_ip_on_launch = false
tags = {
    Name = "mypvtsubnet"
}
}

resource "aws_subnet" "pubsubnet" {
vpc_id            = aws_vpc.myvpc.id
cidr_block        = var.public_subnet_cidr
availability_zone = "us-east-1a"
map_public_ip_on_launch = true
tags = {
    Name = "mypubsubnet"
}
}

resource "aws_internet_gateway" "myigw" {
vpc_id = aws_vpc.myvpc.id
tags = {
    Name = "myigw"
}
}

resource "aws_default_route_table" "myroute" {
default_route_table_id = aws_vpc.myvpc.default_route_table_id
route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.myigw.id
}
tags = {
    Name = "myroute"
}
}

resource "aws_route_table_association" "routeassoc" {
subnet_id      = aws_subnet.pubsubnet.id
route_table_id = aws_default_route_table.myroute.id
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
ami           = "ami-0ecb62995f68bb549"
instance_type = "t3.micro"

subnet_id              = aws_subnet.pubsubnet.id
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

}

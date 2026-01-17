provider "aws" {
region = "us-east-1"
}

resource "aws_vpc" "myvpc" {
cidr_block = "10.0.0.0/16"
tags = {
    Name = "myvpc"
}
}

resource "aws_subnet" "pvtsubnet" {
vpc_id            = aws_vpc.myvpc.id
availability_zone = "us-east-1a"
cidr_block        = "10.0.1.0/24"
map_public_ip_on_launch = false
tags = {
    Name = "mypvtsubnet"
}
}

resource "aws_subnet" "pubsubnet" {
vpc_id            = aws_vpc.myvpc.id
cidr_block        = "10.0.2.0/24"
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
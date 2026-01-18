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
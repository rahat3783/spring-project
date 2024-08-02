provider "aws" {
  region = var.region # Change to your AWS region
}
resource "aws_vpc" "demovpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true

  tags ={
    name = "demovpc"
  }
  
}
 resource "aws_subnet" "subnet1" {
  vpc_id = aws_vpc.demovpc.id
  cidr_block = "10.0.1.0/24"
   tags = {
     name= "demosubnet"
   }
 }
resource "aws_security_group" "demosg" {
  name = "demosg"
  description = "allow inbound and uotbond traffic"
  vpc_id = aws_vpc.demovpc.id
   
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
}

resource "aws_instance" "demoweb" {

  ami = var.ami
  instance_type = var.type
  vpc_security_group_ids = [aws_security_group.demosg.id]
  subnet_id = aws_subnet.subnet1.id
  tags = {
    name= "webserver"
}
}

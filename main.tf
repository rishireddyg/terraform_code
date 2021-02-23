provider "aws" {
    region = "ap-south-1"  
}

resource "aws_vpc" "vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "pt-vpc"
  }
}
resource "aws_subnet" "subnet" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "ap-south-1a"
  map_public_ip_on_launch = true


  tags = {
    Name = "pt-subnet"
  }
}
resource "aws_security_group" "securitygroup" {
  name        = "allow_all_traffic"
  description = "Allow all traffic"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    description = "all trafiic"
    from_port   =  22
    to_port     =  22
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
    Name = "allow_all_traffic"
  }
}
resource "aws_instance" "instance" {
  ami           = "ami-08e0ca9924195beba"
  instance_type = "t2.micro"
  #associate_public_ip_address = true
  availability_zone = "ap-south-1a"
  key_name = "dotexe"
  monitoring = true
  subnet_id = aws_subnet.subnet.id
  vpc_security_group_ids = [aws_security_group.securitygroup.id]


  tags = {
    Name = "HelloWorld"
  }
}
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "gateway"
  }
}
resource "aws_route_table" "routetable" {
  vpc_id = aws_vpc.vpc.id
   route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  

  
  tags = {
    Name = "routetable"
  }
}
resource "aws_route_table_association" "association" {
  subnet_id      = aws_subnet.subnet.id
  route_table_id = aws_route_table.routetable.id
  #gateway_id = aws_internet_gateway.gw.id
}
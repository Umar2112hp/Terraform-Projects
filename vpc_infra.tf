#vpc
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.20.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}

resource "aws_vpc" "auto" {
  cidr_block = "10.0.0.0/16"
  tags = {

    Name = "auto"
    env  = "dev"
  }
}
resource "aws_subnet" "webb" {
  vpc_id            = aws_vpc.auto.id
  availability_zone = "ap-south-1a"
  cidr_block        = "10.0.1.0/24"
  tags = {
    Name = "webb"
    env  = "dev"

  }
}
resource "aws_subnet" "appp" {
  vpc_id            = aws_vpc.auto.id
  availability_zone = "ap-south-1a"
  cidr_block        = "10.0.2.0/24"
  tags = {
    Name = "appp"
    env  = "dev"
  }
}

resource "aws_subnet" "dbb" {
  vpc_id            = aws_vpc.auto.id
  availability_zone = "ap-south-1a"
  cidr_block        = "10.0.3.0/24"
  tags = {
    Name = "dbb"
    env  = "dev"
  }
}
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.auto.id
  tags = {
    Name = "igw"
    env  = "dev"
  }
}
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.auto.id
  tags = {
    Name = "public"
  }
}
resource "aws_route_table" "pvt" {
  vpc_id = aws_vpc.auto.id
  tags = {
    Name = "pvt"
  }
}
resource "aws_route_table_association" "webb" {
  subnet_id      = aws_subnet.webb.id
  route_table_id = aws_route_table.public.id
}
resource "aws_route_table_association" "appp" {
  subnet_id      = aws_subnet.appp.id
  route_table_id = aws_route_table.pvt.id
}
resource "aws_route_table_association" "dbb" {
  subnet_id      = aws_subnet.dbb.id
  route_table_id = aws_route_table.pvt.id

}


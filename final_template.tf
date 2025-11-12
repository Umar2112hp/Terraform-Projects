terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.20"
    }
  }
}


provider "aws" {
  region = "ap-south-1"
}
resource "aws_vpc" "my_vpc" {
  cidr_block = var.vpc_info.cidr
  region     = var.vpc_info.region
  tags       = var.vpc_info.tags
}
resource "aws_subnet" "public_subnets" {

  cidr_block        = var.public_subnets.cidr
  vpc_id            = aws_vpc.my_vpc.id
  availability_zone = var.public_subnets.az
  tags              = var.public_subnets.tags
}

resource "aws_subnet" "my_subnet" {
  count             = length(var.subnet_info)
  cidr_block        = var.subnet_info[count.index].cidr
  vpc_id            = aws_vpc.my_vpc.id
  availability_zone = var.subnet_info[count.index].az
  tags              = var.subnet_info[count.index].tags
}

resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = "gateway"
  }
}

resource "aws_route_table" "public" {

  vpc_id = aws_vpc.my_vpc.id
  tags   = var.public_route_table_info.tags
}

resource "aws_route_table" "private" {

  vpc_id = aws_vpc.my_vpc.id
  tags   = var.private_route_table_info.tags
}

resource "aws_route" "internet_access" {
  route_table_id         = aws_route_table.public.id
  gateway_id             = aws_internet_gateway.my_igw.id
  destination_cidr_block = "0.0.0.0/16"

}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public_subnets.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private" {
  count          = length(var.private_route_table_association)
  subnet_id      = aws_subnet.my_subnet[count.index].id
  route_table_id = aws_route_table.private.id

}



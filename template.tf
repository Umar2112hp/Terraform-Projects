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
resource "aws_vpc" "my_vpc" {
  cidr_block = var.vpc_info.cidr
  region     = var.vpc_info.region
  tags       = var.vpc_info.tags
}
resource "aws_subnet" "my_subnet" {
  count             = length(var.subnet_info)
  cidr_block        = var.subnet_info[count.index].cidr
  vpc_id            = aws_vpc.my_vpc.id
  availability_zone = var.subnet_info[count.index].az
  tags              = var.subnet_info[count.index].tags
}



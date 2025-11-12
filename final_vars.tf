variable "vpc_info" {
  type = object({
    cidr   = string
    region = string
    tags   = map(string)
  })
  default = {
    cidr   = "192.168.0.0/16"
    region = "ap-south-1"
    tags = {
      Name = "my_vpc"
      Env  = "dev"
    }
  }
}
variable "public_subnets" {
  type = object({
    vpc_id = string
    cidr   = string
    az     = string
    tags   = map(string)
  })
  default = {
    vpc_id = "aws_vpc.my_vpc.id"
    cidr   = "192.168.0.0/24"
    az     = "ap-south-1a"
    tags = {
      Name = "web"
    }
  }
}
variable "subnet_info" {
  type = list(object({
    vpc_id = string
    cidr   = string
    az     = string
    tags   = map(string)
  }))

  default = [{
    vpc_id = "aws_vpc.my_vpc.id"
    cidr   = "192.168.1.0/24"
    az     = "ap-south-1b"
    tags = {
      Name = "app"
    }
    }, {

    vpc_id = "aws_vpc.my_vpc.id"
    cidr   = "192.168.2.0/24"
    az     = "ap-south-1c"
    tags = {
      Name = "db"
    }

  }]
}

variable "public_route_table_info" {
  type = object({
    vpc_id = string
    tags   = map(string)
  })
  default = {
    vpc_id = "aws_vpc.my_vpc.id"
    tags = {
      Name = "public"
    }
  }

}
variable "private_route_table_info" {
  type = object({
    vpc_id = string
    tags   = map(string)
  })
  default = {
    vpc_id = "aws_vpc.my_vpc.id"
    tags = {
      Name = "Private"
    }
  }
}



variable "public_route_table_association" {
  type = object({

    subnet_id      = string
    route_table_id = string
  })
  default = {

    subnet_id      = "aws_subnet.web.id"
    route_table_id = "aws_route_table.public.id"

  }
}

variable "private_route_table_association" {
  type = list(object({
    subnet_id      = string
    route_table_id = string
  }))
  default = [{
    route_table_id = "aws_route_table.private.id"
    subnet_id      = "aws_subnet.app.id"
    }, {
    route_table_id = "aws_route_table.private.id"
    subnet_id      = "aws_subnet.db.id"

  }]

}









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
variable "subnet_info" {
  type = list(object({
    vpc_id = string
    cidr   = string
    az     = string
    tags   = map(string)
  }))
  default = [{
    vpc_id = "aws_vpc.my_vpc.id"
    cidr   = "192.168.0.0/24"
    az     = "ap-south-1a"
    tags = {
      Name = "web"
    }
    }, {
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
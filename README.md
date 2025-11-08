# AWS VPC and Subnets Terraform Configuration

## Overview
This Terraform configuration provisions a basic AWS networking setup in the Mumbai (`ap-south-1`) region.
It creates a Virtual Private Cloud (VPC), three subnets (one public and two private), an Internet Gateway, and route tables with appropriate associations for subnet routing.

---

## Resources Created
- **aws_vpc.auto**: VPC with CIDR block `10.0.0.0/16`
- **aws_subnet.webb**: Public subnet in availability zone `ap-south-1a` with CIDR `10.0.1.0/24`
- **aws_subnet.appp**: Private subnet in `ap-south-1a` with CIDR `10.0.2.0/24`
- **aws_subnet.dbb**: Private subnet in `ap-south-1a` with CIDR `10.0.3.0/24`
- **aws_internet_gateway.igw**: Internet Gateway attached to the VPC for internet connectivity
- **aws_route_table.public**: Route table for public subnet
- **aws_route_table.pvt**: Route table for private subnets
- **aws_route_table_association**: Associates subnets with their corresponding route tables

---



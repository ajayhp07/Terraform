# LOOPS
# count based loop mostly works on list.
#  for_each loops, works with map usually

# TASK
# Create 2 public subnet and 2 private subnet  

# 1 create vpc
resource "aws_vpc" "main" {
    cidr_block = "10.0.0.0/16"
    instance_tenancy = "default"
    enable_dns_hostnames = true
    enable_dns_support =  true
    tags = {
      Name = "myvpc"
    }
  
}

# count based subnet
resource "aws_subnet" "public_subnet" {
    count = length(var.public_subnet_cidr) #count = 2
    vpc_id = aws_vpc.main.id
    cidr_block = var.public_subnet_cidr[count.index] 
    availability_zone = var.azs[count.index] 
    tags = {
      Name = var.public_subnet_names[count.index]
    }
}

# foreach based subnet
resource "aws_subnet" "private_subnet" {
    for_each = var.private_subnet
    vpc_id = aws_vpc.main.id
    cidr_block = each.value.cidr 
    # availability_zone = each.value.azs
    tags = {
      Name = each.value.Name
    }
}
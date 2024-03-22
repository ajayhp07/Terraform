# create internet gateway

resource "aws_internet_gateway" "main" {
    vpc_id = aws_vpc.main.id
    tags = {
        Name = "timing"
        Terraform = "true"
        Environment = "Dev" 
      
    }
  
}

#  Create vpc through terraform 

 resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  instance_tenancy = "default"
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "timing"
    Terraform = "true"
    Environment = "Dev" 
  }
}

# create public_subnet
resource "aws_subnet" "public_subnet" {
    vpc_id = aws_vpc.main.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "us-east-1a"
    tags = {
        Name = "timing-public-subnet"
        Terraform = "true"
        Environment = "Dev"
    }
  
}
# create a public-route-table
resource "aws_route_table" "public_route_table" {
    vpc_id = aws_vpc.main.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.main.id
    }
    tags = {
        Name = "timing-public-rt"
        Terraform = "true"
        Environment = "Dev"
    }
}
# create a association of route table  

resource "aws_route_table_association" "public" {
    subnet_id = aws_subnet.public_subnet.id
    route_table_id = aws_route_table.public_route_table.id
  
}

# create private_subnet
resource "aws_subnet" "private_subnet" {
    vpc_id = aws_vpc.main.id
    cidr_block = "10.0.11.0/24"
    availability_zone = "us-east-1b"
    tags = {
        Name = "timing-private-subnet"
        Terraform = "true"
        Environment = "Dev"
    }
  
}

# create a private-route-table
resource "aws_route_table" "private_route_table" {
    vpc_id = aws_vpc.main.id
    tags = {
        Name = "timing-private-rt"
        Terraform = "true"
        Environment = "Dev"
    }
}

# create a association of route table  

resource "aws_route_table_association" "private" {
    subnet_id = aws_subnet.private_subnet.id
    route_table_id = aws_route_table.private_route_table.id
  
}

# create database_subnet
resource "aws_subnet" "database_subnet" {
    vpc_id = aws_vpc.main.id
    cidr_block = "10.0.21.0/24"
    availability_zone = "us-east-1c"
    tags = {
        Name = "timing-database-subnet"
        Terraform = "true"
        Environment = "Dev"
    }
  
}
# database route table creation

resource "aws_route_table" "database_rt" {
    vpc_id = aws_vpc.main.id
    tags = {
        Name = "timing-database-rt"
        Terraform = "true"
        Environment = "Dev"
    }
}

# database ko association kiye database subnet se aur route se 

resource "aws_route_table_association" "database" {
    subnet_id = aws_subnet.database_subnet.id
    route_table_id = aws_route_table.database_rt.id  
}

# Create elastic ip for natgate 
resource "aws_eip" "nat" {
    domain = "vpc"
  
}

# Attaching elasticip to natgate and natgate to public subnet 
resource "aws_nat_gateway" "gw" {
    allocation_id = aws_eip.nat.id
    subnet_id = aws_subnet.public_subnet.id  
}

# Attaching NATGATE to private route for making the communication between public subnet and private subnet 
resource "aws_route" "private" {
    route_table_id = aws_route_table.private_route_table.id
    destination_cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.gw.id
}

# Adding route to database also  
resource "aws_route" "database" {
    route_table_id = aws_route_table.database_rt.id
    destination_cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.gw.id
}

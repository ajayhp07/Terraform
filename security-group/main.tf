# 1: STEPS TO CREATE A SECURITY GROUP IS TO MAKE VPC AND AFTER THAT SECURITY-GROUP  

#  1 STEP TO MAKE VPC
resource "aws_vpc" "main" {
    cidr_block = var.cidr_block
    instance_tenancy = var.instance_tenancy
    enable_dns_hostnames = var.dns_hostnames 
    enable_dns_support =  var.dns_support
    tags = var.tags
}

# 2 create security group FOR POSTGRES [5432]
resource "aws_security_group" "allow_postgres" {
    name = "allow_postgres"
    vpc_id = aws_vpc.main.id

    ingress {
        from_port = var.postgres_port
        to_port = var.postgres_port
        protocol = "tcp"
        cidr_blocks = var.cidr_list
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
    }
    tags = var.tags
  
}
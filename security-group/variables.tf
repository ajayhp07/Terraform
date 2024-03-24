variable "cidr_block" {
    type = string
    default = "10.0.0.0/24"
}

variable "instance_tenancy" {
    type = string
    default = "default" 
}

variable "dns_hostnames" {
    type = bool
    default = true 
}

variable "dns_support" {
    type = bool
    default = true 
}

variable "tags" {
    type = map(string)
    default = {
      "Name" = "myvpc"
    }
  
}
variable "postgres_port" {
    type = number
    default = 5432
}

variable "cidr_list" {
    type = list
    # you providing two cidr block means its create 2 inbound rules that is attach in that security group
    default = ["10.0.1.0/24", "10.0.2.0/24"]
}
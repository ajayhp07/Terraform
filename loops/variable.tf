# count based concept
variable "public_subnet_cidr" {
    type = list
    default = ["10.0.1.0/24" , "10.0.2.0/24"]
}

variable "azs" {
    type = list
    default = ["us-east-1a" , "us-east-1b"]
}
variable "public_subnet_names" {
    type = list
    default = ["public-1a" , "public-1b"] 
    
}
# private_subnet

variable "private_subnet" {
    type = map 
    default = {
        private_subnet-1 = {
            Name = "private-1a"
            cidr = "10.0.3.0/24"
            availability_zone = "us-east-1b"
        }
        private_subnet-2 = {
            Name = "private-1b"
            cidr = "10.0.4.0/24"
            availability_zone = "us-east-1a"
        }
    }

}
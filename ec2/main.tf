resource "aws_key_pair" "us-east" {
    key_name = "us-east"
    public_key = file("C:\\Users\\user\\Desktop\\terraform\\ec2\\us-east.pub")
}

resource "aws_instance" "amit" {
    key_name = aws_key_pair.us-east.key_name
    ami = "ami-080e1f13689e07408"
    instance_type = "t2.micro"
    count = 2
    availability_zone = "us-east1a"
  
}
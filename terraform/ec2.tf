provider "aws" {
    region = "us-east-2"
  
}



resource "aws_instance" "ec2" {
    ami= "ami-0ca4d5db4872d0c28"
    instance_type = "t2.micro"
    key_name = "athrav-ohio"
    security_groups = [ "default" ]
  
   tags = {
     Name = "my-server"
   }
}
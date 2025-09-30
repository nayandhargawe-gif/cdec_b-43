provider "aws" {
    region = "us-east-2"
  
}



resource "aws_instance" "ec2" {
    ami= var.image_id
    instance_type = var.instance_type
    key_name = var.key_pair
    security_groups = [ "default" ]
  
   tags = {
     Name = "my-server"
   }
}

variable image_id {
  type        = string
  default     = "ami-0ca4d5db4872d0c28"
  description = "ENTER AMI ID"
}


variable instance_type {
  type = string
  default = "t2.micro"
}

variable key_pair {
  type = string
  default = "thrav-ohio"
}

output public_ip {
  value       = aws_instance.ec2.public_ip
}

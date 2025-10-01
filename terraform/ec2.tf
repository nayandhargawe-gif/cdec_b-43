provider "aws" {
  region = "us-east-2"

}


resource "aws_security_group" "my-tf-sg" {
  name        = "tf-sg"
  description = "Allow all TCP"

  ingress {
    from_port  = 80
    to_port    = 80
    protocol   = "TCP"
    cidr_blocks = ["0.0.0.0/0"]

  }
  egress {
    from_port  = 0
    to_port    = 0
    protocol   = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }

}

resource "aws_instance" "my_instance" {
  ami           = var.image_id
  instance_type = var.instance_type
  key_name      = var.key_pair
  # security_groups = ["default"]  # Ensure this security group exists
  vpc_security_group_ids = [aws_security_group.my-tf-sg.id]

  user_data = <<-EOT
  #!/bin/bash
sudo yum update -y
sudo yum install httpd -y
sudo systemctl start httpd
sudo systemctl enable httpd
  EOT


  tags = {
    Name = "My-Terraform-Instance"
  }
}

variable "image_id" {
  type        = string
  default     = "ami-0ca4d5db4872d0c28"
  description = "ENTER AMI ID"
}


variable "instance_type" {

  type    = string
  default = "t3.medium"
}

variable "key_pair" {
  type    = string
  default = "athrav-ohio"
}

output "public_ip" {
  value = aws_instance.my_instance.public_ip
}






























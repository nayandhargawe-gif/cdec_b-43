


resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16"
  

  tags = {
    Name = "main"
  }
}

resource "aws_subnet" "main" {

  vpc_id = aws_vpc.main.id
  cidr_block = var.pub_subnet
  map_public_ip_on_launch = true
  

  tags = {
    Name = "pub-subnet"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "my-igw"
  }
}


resource "aws_default_route_table" "main-rt" {
  default_route_table_id = aws_vpc.main.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

 
  tags = {
    Name = "main-rt"
  }
}


resource "aws_security_group" "my-tf-sg" {
  name        = "my-tf-sg"
  description = "Allow all TCP"
   vpc_id = aws_vpc.main.id

  ingress {
    from_port  = 80
    to_port    = 80
    protocol   = "TCP"
    cidr_blocks = ["0.0.0.0/0"]

  }
   ingress {
    from_port  = 22
    to_port    = 22
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
  subnet_id = aws_subnet.main.id


  tags = {
    Name = "my-vpc-instance"
  }
}
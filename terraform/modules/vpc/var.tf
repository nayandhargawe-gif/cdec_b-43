variable "pub_subnet"{
    #default = "10.0.0.0/20"
}

variable "instance_type" {
    default ="t2.micro"
}

variable "key_pair" {
    default = "singa-athrva"
}

variable "image_id" {
    default = "ami-0933f1385008d33c4"
}
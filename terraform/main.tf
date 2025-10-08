provider "aws" {
    region = "ap-southeast-1"
}



module "aws_instance_basic"{


    source = "./modules/vpc"
}
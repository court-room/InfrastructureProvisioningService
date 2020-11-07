variable "aws-vpc-cidr" {
    type = string
    default = "10.0.0.0/16"
}

resource "aws_vpc" "rinnegan_vpc" {
    cidr_block = var.aws-vpc-cidr
    instance_tenancy = "default"
    tags = {
        "Name" = "Rinnegan VPC"
        "Terraform" = "True"
    }
}
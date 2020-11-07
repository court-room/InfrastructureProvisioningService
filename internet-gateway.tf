resource "aws_internet_gateway" "rinnegan-internet-gateway" {
    vpc_id = aws_vpc.rinnegan_vpc.id
    tags = {
        "Name" = "Rinnegan Internet Gateway"
        "Terraform" = "True"
    }
}
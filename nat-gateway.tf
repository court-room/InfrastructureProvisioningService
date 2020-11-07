resource "aws_eip" "rinnegan-nat1" {}

resource "aws_eip" "rinnegan-nat2" {}

resource "aws_nat_gateway" "rinnegan-nat-gateway-1a" {
    allocation_id = aws_eip.rinnegan-nat1.id
    subnet_id = aws_subnet.rinnegan-public-1a.id
    tags = {
        "Name" = "Rinnegan NAT Gateway 1A"
        "Terraform" = "True"
    }
}

resource "aws_nat_gateway" "rinnegan-nat-gateway-1b" {
    allocation_id = aws_eip.rinnegan-nat2.id
    subnet_id = aws_subnet.rinnegan-public-1b.id
    tags = {
        "Name" = "Rinnegan NAT Gateway 1B"
        "Terraform" = "True"
    }
}
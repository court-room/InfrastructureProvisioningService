resource "aws_route_table" "rinnegan-public" {
    vpc_id = aws_vpc.rinnegan_vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.rinnegan-internet-gateway.id
    }
    tags = {
        "Name" = "Rinnegan Public route table"
        "Terraform" = "True"
    }
}

resource "aws_route_table_association" "rinnegan-public-1a-association" {
    subnet_id = aws_subnet.rinnegan-public-1a.id
    route_table_id = aws_route_table.rinnegan-public.id
}

resource "aws_route_table_association" "rinnegan-public-1b-association" {
    subnet_id = aws_subnet.rinnegan-public-1b.id
    route_table_id = aws_route_table.rinnegan-public.id
}
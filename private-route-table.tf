resource "aws_route_table" "rinnegan-private-route-table-1a" {
    vpc_id = aws_vpc.rinnegan_vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_nat_gateway.rinnegan-nat-gateway-1a.id
    }
    tags = {
        "Name" = "Rinnegan Private route table 1A"
        "Terraform" = "True"
    }
}

resource "aws_route_table_association" "rinnegan-private-1a-association" {
    subnet_id = aws_subnet.rinnegan-private-1a.id
    route_table_id = aws_route_table.rinnegan-private-route-table-1a.id
}

resource "aws_route_table" "rinnegan-private-route-table-1b" {
    vpc_id = aws_vpc.rinnegan_vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_nat_gateway.rinnegan-nat-gateway-1b.id
    }
    tags = {
        "Name" = "Rinnegan Private route table 1B"
        "Terraform" = "True"
    }
}

resource "aws_route_table_association" "rinnegan-private-1b-association" {
    subnet_id = aws_subnet.rinnegan-private-1b.id
    route_table_id = aws_route_table.rinnegan-private-route-table-1b.id
}
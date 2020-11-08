resource "aws_security_group" "rinnegan-bastion-security-group" {
    vpc_id = aws_vpc.rinnegan_vpc.id
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = [
            "0.0.0.0/0" # Update this for specific IPs or a VPN setup for more privacy
        ]
    }
    tags = {
        "Name" = "Rinnegan Bastion Security Group"
        "Terraform" = "True"
    }
}

resource "aws_instance" "rinnegan-bastion-host-1a" {
    ami = "ami-0823c236601fef765"
    instance_type = "t2.micro"
    key_name = aws_key_pair.rinnegan-ssh-key.key_name
    associate_public_ip_address = true
    vpc_security_group_ids = [
        aws_security_group.rinnegan-bastion-security-group.id
    ]
    subnet_id = aws_subnet.rinnegan-public-1a.id
    tags = {
        "Name" = "Rinnegan Bastion Host 1A"
        "Terraform" = "True"
    }
}

resource "aws_instance" "rinnegan-bastion-host-1b" {
    ami = "ami-0823c236601fef765"
    instance_type = "t2.micro"
    key_name = aws_key_pair.rinnegan-ssh-key.key_name
    associate_public_ip_address = true
    vpc_security_group_ids = [
        aws_security_group.rinnegan-bastion-security-group.id
    ]
    subnet_id = aws_subnet.rinnegan-public-1b.id
    tags = {
        "Name" = "Rinnegan Bastion Host 1B"
        "Terraform" = "True"
    }
}
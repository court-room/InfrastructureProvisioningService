resource "aws_security_group" "rinnegan-alb-security-group" {
    vpc_id = aws_vpc.rinnegan_vpc.id
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = [
            "0.0.0.0/0"
        ]
    }
    ingress {
        from_port = 443
        to_port = 443 
        protocol = "tcp"
        cidr_blocks = [
            "0.0.0.0/0"
        ]
    }
    tags = {
      "Name" = "Rinnegan ALB Security Group"
      "Terraform" = "True"
    }
}

resource "aws_lb" "rinnegan-alb" {
    name = "rinnegan-application-lb"
    internal = false
    load_balancer_type = "application"
    security_groups = [
        aws_security_group.rinnegan-alb-security-group.id
    ]
    subnets = [
        aws_subnet.rinnegan-public-1a.id,
        aws_subnet.rinnegan-public-1b.id
    ]
    enable_deletion_protection = false
    tags = {
      "Name" = "Rinnegan Application Load Balancer"
      "Terraform" = "True"
    }
}
resource "aws_security_group" "rinnegan-asg-sg" {
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
        from_port = 80
        to_port = 80
        protocol = "tcp"
        security_groups = [
            aws_security_group.rinnegan-alb-security-group.id
        ]
    }
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        security_groups = [
            aws_security_group.rinnegan-bastion-security-group.id
        ]
    }
    tags = {
      "Name" = "Rinnegan Auto Scaling Group Security Group"
      "Terraform" = "True"
    }
}

resource "aws_launch_configuration" "rinnegan-launch-configuration" {
    name_prefix = "Rinnegan Launch Configuration"
    image_id = "ami-0dc8d444ee2a42d8a"
    instance_type = "t2.micro"
    key_name = aws_key_pair.rinnegan-ssh-key.key_name
    security_groups = [
        aws_security_group.rinnegan-asg-sg.id
    ]
    lifecycle {
      create_before_destroy = true
    }
}

resource "aws_autoscaling_group" "rinnegan-front-end" {
    name = "Rinnegan Front End Auto Scaling Group"
    launch_configuration = aws_launch_configuration.rinnegan-launch-configuration.name
    health_check_type = "ELB"
    min_size = 0
    max_size = 0
    desired_capacity = 0
    vpc_zone_identifier = [
        aws_subnet.rinnegan-private-1a.id,
        aws_subnet.rinnegan-private-1b.id,
    ]
    target_group_arns = [
        aws_lb_target_group.rinnegan-front-end-target-group.arn
    ]
    lifecycle {
      create_before_destroy = true
    }
    tag {
        key = "Name"
        value = "Rinengan Front End Auto Scaling Group"
        propagate_at_launch = true
    }
}

resource "aws_autoscaling_group" "rinnegan-back-end" {
    name = "Rinnegan Back End Auto Scaling Group"
    launch_configuration = aws_launch_configuration.rinnegan-launch-configuration.name
    health_check_type = "ELB"
    min_size = 0
    max_size = 0
    desired_capacity = 0
    vpc_zone_identifier = [
        aws_subnet.rinnegan-private-1a.id,
        aws_subnet.rinnegan-private-1b.id,
    ]
    target_group_arns = [
        aws_lb_target_group.rinnegan-back-end-target-group.arn
    ]
    lifecycle {
      create_before_destroy = true
    }
    tag {
        key = "Name"
        value = "Rinengan Back End Auto Scaling Group"
        propagate_at_launch = true
    }
}
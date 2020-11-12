resource "aws_security_group" "rinnegan-efs-sg" {
    name = "Rinnegan Elastic File System Security Group"
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
        from_port = 2049
        to_port = 2049
        protocol = "tcp"
        security_groups = [
            aws_security_group.rinnegan-asg-sg.id
        ]
    }
    tags = {
      "Name" = "Rinnegan EFS Security Group"
      "Terraform" = "True"
    }
}

resource "aws_efs_file_system" "rinnegan-efs" {
    creation_token = "rinnegan-elastic-file-system"
    performance_mode = "generalPurpose"
    throughput_mode = "bursting"
    tags = {
        "Name" = "Rinnegan Elastic File System"
        "Terraform" = "True"
    }
}

resource "aws_efs_mount_target" "rinnegan-mount-private-1a" {
    file_system_id = aws_efs_file_system.rinnegan-efs.id
    subnet_id = aws_subnet.rinnegan-private-1a.id
    security_groups = [
        aws_security_group.rinnegan-efs-sg.id
    ]
}

resource "aws_efs_mount_target" "rinnegan-mount-private-1b" {
    file_system_id = aws_efs_file_system.rinnegan-efs.id
    subnet_id = aws_subnet.rinnegan-private-1b.id
    security_groups = [
        aws_security_group.rinnegan-efs-sg.id
    ]
}
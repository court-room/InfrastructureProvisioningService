resource "aws_security_group" "rinnegan-db-sg" {
    name = "Rinnegan RDS Security Group"
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
        from_port = 3306
        to_port = 3306
        protocol = "tcp"
        security_groups = [
            aws_security_group.rinnegan-asg-sg.id
        ]
    }
    tags = {
      "Name" = "RDS Security Group"
      "Terraform" = "True"
    }
}

resource "aws_db_subnet_group" "rinnegan-db-subnet" {
    name = "rinnegan-database-subnet-group"
    subnet_ids = [
        aws_subnet.rinnegan-private-1a.id,
        aws_subnet.rinnegan-private-1b.id
    ]
    tags = {
      "Name" = "Rinengan DB Subnet Group"
      "Terraform" = "True"
    }
}

resource "aws_db_instance" "rinnegan-db" {
    allocated_storage = "10"
    storage_type = "gp2"
    engine = "mysql"
    engine_version = "5.6"
    multi_az = true
    instance_class = "db.t2.micro"
    name = "rinnegan"
    username = "admin"
    password = var.db-master-password
    identifier = "rinnegan-database"
    skip_final_snapshot = true
    backup_retention_period = "7"
    port = "3306"
    storage_encrypted = false
    db_subnet_group_name = aws_db_subnet_group.rinnegan-db-subnet.name
    vpc_security_group_ids = [
        aws_security_group.rinnegan-db-sg.id
    ]
    tags = {
      "Name" = "Rinnegan Database"
      "Terraform" = "True"
    }
}
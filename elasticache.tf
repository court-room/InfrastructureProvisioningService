resource "aws_security_group" "rinnegan-elasticache-sg" {
    name = "Rinnegan Elasticache Security Group"
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
        from_port = 6379
        to_port = 6379
        protocol = "tcp"
        security_groups = [
            aws_security_group.rinnegan-asg-sg.id
        ]
    }
    tags = {
      "Name" = "Rinnegan Elasticache Security Group"
      "Terraform" = "True"
    }
}

resource "aws_elasticache_subnet_group" "rinnegan-elasticache-subnet" {
    name = "rinnegan-elasticache-subnet-group"
    subnet_ids = [
        aws_subnet.rinnegan-private-1a.id,
        aws_subnet.rinnegan-private-1b.id
    ]
}

resource "aws_elasticache_replication_group" "rinnegan-elasticache" {
    automatic_failover_enabled = true
    replication_group_id = "rinnegan-replication-group"
    replication_group_description = "Rinnegan Elasticache Replication Group"
    node_type = "cache.t2.micro"
    number_cache_clusters = 2
    engine_version = "5.0.4"
    parameter_group_name = "default.redis5.0"
    port = 6379
    subnet_group_name = aws_elasticache_subnet_group.rinnegan-elasticache-subnet.name
    security_group_ids = [
        aws_security_group.rinnegan-elasticache-sg.id
    ]
    tags = {
      "Name" = "Rinnegan Elasticache Replication Group"
      "Terraform" = "True"
    }
}
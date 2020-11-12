resource "aws_lb_target_group" "rinnegan-front-end-target-group" {
    port = 80
    protocol = "HTTP"
    name = "rinnegan-front-end-target-group"
    vpc_id = aws_vpc.rinnegan_vpc.id
    stickiness {
      type = "lb_cookie"
      enabled = true
    }
    health_check {
      protocol = "HTTP"
      path = "/healthy.html"
    #   Very rapid health check threshold, edit in production
      healthy_threshold = 2
      unhealthy_threshold = 2
      timeout = 5
      interval = 10
    }
    tags = {
      "Name" = "Rinnegan Front End Target Group"
      "Terraform" = "True"
    }
}

resource "aws_lb_target_group" "rinnegan-back-end-target-group" {
    port = 80
    protocol = "HTTP"
    name = "rinnegan-back-end-target-group"
    vpc_id = aws_vpc.rinnegan_vpc.id
    stickiness {
      type = "lb_cookie"
      enabled = true
    }
    health_check {
        protocol = "HTTP"
        path = "/healthy.html"
        # Very rapid health check threshold, edit in production
        healthy_threshold = 2
        unhealthy_threshold = 2
        timeout = 5
        interval = 10
    }
    tags = {
      "Name" = "Rinnegan Back End Target Group"
      "Terraform" = "True"
    }
}
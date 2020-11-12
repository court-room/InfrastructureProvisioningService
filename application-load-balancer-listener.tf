resource "aws_lb_listener" "rinnegan-https" {
    load_balancer_arn = aws_lb.rinnegan-alb.arn
    port = 443
    protocol = "HTTPS"
    ssl_policy = "ELBSecurityPolicy-TLS-1-0-2015-04"
    certificate_arn = "arn:aws:acm:eu-west-1:783729352349:certificate/c1558517-8377-4aee-8756-b1a94d20a62d"
    default_action {
      type = "forward"
      target_group_arn = aws_lb_target_group.rinnegan-front-end-target-group.arn
    }
}

resource "aws_lb_listener_rule" "rinnegan-admin-https" {
    listener_arn = aws_lb_listener.rinnegan-https.arn
    priority = 100
    action {
      type = "forward"
      target_group_arn = aws_lb_target_group.rinnegan-back-end-target-group.arn
    }
    condition {
      path_pattern {
        values = [
            "/admin"
        ]
      }
    }
}
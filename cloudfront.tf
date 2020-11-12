locals {
  rinnegan-origin-id = "rinnegan-origin"
}

resource "aws_cloudfront_distribution" "rinnegan-distribution" {
    origin {
      domain_name = aws_lb.rinnegan-alb.dns_name
      origin_id = local.rinnegan-origin-id
      custom_origin_config {
        http_port = "80"
        https_port = "443"
        origin_protocol_policy = "https-only"
        origin_ssl_protocols = [
            "TLSv1"
        ]
      }
    }
    enabled = true
    is_ipv6_enabled = true
    comment = "rinnegan-cloudfront-distribution"
    aliases = [
        "cdn.rinnegan.io"
    ]
    default_cache_behavior {
        allowed_methods = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
        cached_methods = ["GET", "HEAD"]
        target_origin_id = local.rinnegan-origin-id
        viewer_protocol_policy = "redirect-to-https"
        compress = true
        min_ttl = 0
        default_ttl = 3600
        max_ttl = 86400
        forwarded_values {
          query_string = false
          headers = ["host","origin","Access-Control-Request-Headers","Access-Control-Request-Method"]
          cookies {
            forward = "none"
          }
        }
    }
    price_class = "PriceClass_All"
    restrictions {
        geo_restriction {
          restriction_type = "none"
        }
    }
    viewer_certificate {
        cloudfront_default_certificate = false
        ssl_support_method = "sni-only"
        minimum_protocol_version = "TLSv1.2_2018"
        acm_certificate_arn = "arn:aws:acm:us-east-1:783729352349:certificate/5e52fa95-f8fe-4f25-91c7-f74de82f9aaf"
    }
}
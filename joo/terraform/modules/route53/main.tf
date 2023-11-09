################################################################################
# Route53 Zone
################################################################################

resource "aws_route53_zone" "private" {
  name          = "joo.com"
  comment       = "Private DNS for Private LB"
  force_destroy = true
  vpc {
    vpc_id = var.vpc_id
  }

  tags = merge(
    { "Name" = "${var.name}-private-zone" },
    var.tags
  )
}

################################################################################
# Route53 Record(s)
################################################################################

resource "aws_route53_record" "public_lb" {
  zone_id = data.aws_route53_zone.selected.zone_id
  name    = "test"
  type    = "CNAME"

  alias {
    name                   = var.public_lb_dns_name
    zone_id                = var.public_lb_zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "private_lb" {
  zone_id = aws_route53_zone.private.zone_id
  name    = "test"
  type    = "CNAME"

  alias {
    name                   = var.private_lb_dns_name
    zone_id                = var.private_lb_zone_id
    evaluate_target_health = true
  }
}
resource "aws_route53_zone" "hostedzone" {
  name = "thetraining.info"
}

resource "aws_route53_record" "www" {
  zone_id = aws_route53_zone.hostedzone.zone_id
  name    = "dev.thetraining.info"
  type    = "A"

  alias {
    name                   = aws_lb.alb_3tier.dns_name
    zone_id                = aws_lb.alb_3tier.zone_id
    evaluate_target_health = true
  }
}
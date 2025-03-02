data "aws_route53_zone" "gitea_route53_zone" {
  name = "chipichapa.site"
}

resource "aws_route53_record" "gitea_alb_alias" {
  zone_id = data.aws_route53_zone.gitea_route53_zone.zone_id
  name    = "chipichapa.site"
  type    = "A"

  alias {
    name                   = aws_lb.gitea_alb.dns_name
    zone_id                = aws_lb.gitea_alb.zone_id
    evaluate_target_health = true
  }
}

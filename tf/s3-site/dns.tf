data "aws_route53_zone" "domain" {
  name         = var.dns.domain
  private_zone = false
}

resource "aws_route53_record" "record" {
  zone_id = data.aws_route53_zone.domain.zone_id
  name    = local.full_domain
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.s3_distribution.domain_name
    zone_id                = aws_cloudfront_distribution.s3_distribution.hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "www_record" {
  count   = var.use_www ? 1 : 0
  zone_id = data.aws_route53_zone.domain.zone_id
  name    = "www.${local.full_domain}"
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.s3_redirect_distribution[0].domain_name
    zone_id                = aws_cloudfront_distribution.s3_redirect_distribution[0].hosted_zone_id
    evaluate_target_health = false
  }
}

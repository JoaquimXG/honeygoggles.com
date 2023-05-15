# Cache and Compress
data "aws_cloudfront_cache_policy" "cache_policy" {
  name = "Managed-CachingOptimized"
}

resource "aws_cloudfront_distribution" "s3_distribution" {
  # origin {
  #   domain_name = aws_s3_bucket.site_bucket.bucket_regional_domain_name
  #   origin_id   = var.s3_origin_id
  # }
  // Using an S3 bucket as origin via standard HTTP in order to allow index.html files to be served for subfolders
  origin {
    domain_name = aws_s3_bucket.site_bucket.website_endpoint
    origin_id   = var.s3_origin_id
    custom_origin_config {
      http_port = 80
      https_port = 443
      origin_protocol_policy = "http-only"
      origin_ssl_protocols = [ "TLSv1" ]
    }
  }

  enabled             = true
  is_ipv6_enabled     = true

  aliases = [local.full_domain]

  default_cache_behavior {
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]
    target_origin_id       = var.s3_origin_id
    compress               = true
    viewer_protocol_policy = "redirect-to-https"

    cache_policy_id = data.aws_cloudfront_cache_policy.cache_policy.id
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  price_class = "PriceClass_100"

  viewer_certificate {
    acm_certificate_arn = var.acm_cert_id
    ssl_support_method  = "sni-only"
  }
}

resource "aws_cloudfront_distribution" "s3_redirect_distribution" {
  count = var.use_www ? 1 : 0
  origin {
    domain_name = aws_s3_bucket.redirect_bucket[0].website_endpoint
    origin_id   = local.redirect_origin_id
    custom_origin_config {
      http_port = 80
      https_port = 443
      origin_protocol_policy = "http-only"
      origin_ssl_protocols = [ "TLSv1" ]
    }
  }

  enabled             = true
  is_ipv6_enabled     = true

  aliases = ["www.${local.full_domain}"]

  default_cache_behavior {
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]
    target_origin_id       = local.redirect_origin_id
    compress               = true
    viewer_protocol_policy = "redirect-to-https"

    cache_policy_id = data.aws_cloudfront_cache_policy.cache_policy.id
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  price_class = "PriceClass_100"

  viewer_certificate {
    acm_certificate_arn = var.acm_cert_id
    ssl_support_method  = "sni-only"
  }
}

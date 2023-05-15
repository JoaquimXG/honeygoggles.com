resource "aws_s3_bucket" "redirect_bucket" {
  count  = var.use_www ? 1 : 0
  # bucket = local.full_domain
  bucket = "www.${local.full_domain}" // TODO this is no longer required as cloudfront is infront of this bucket
}

resource "aws_s3_bucket_website_configuration" "redirect_config" {
  count  = var.use_www ? 1 : 0
  bucket = aws_s3_bucket.redirect_bucket[0].bucket

  redirect_all_requests_to {
    host_name = local.full_domain
    protocol = "https"
  }
}

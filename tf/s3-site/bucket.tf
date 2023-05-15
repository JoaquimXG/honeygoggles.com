resource "aws_s3_bucket" "site_bucket" {
  bucket = var.bucket_name
}

resource "aws_s3_bucket_website_configuration" "site_config" {
  bucket = aws_s3_bucket.site_bucket.bucket

  index_document {
    suffix = "index.html"
  }
  error_document {
    key = "404/index.html"
  }
}

resource "aws_s3_bucket_policy" "site_bucket_policy" {
  bucket = aws_s3_bucket.site_bucket.bucket

  policy = <<POLICY
{
  "Version":"2012-10-17",
    "Statement":[
      {
        "Sid":"public-get-all",
        "Effect":"Allow",
        "Principal": "*",
        "Action":["s3:GetObject"],
        "Resource":["${aws_s3_bucket.site_bucket.arn}/*"]
      }
  ]
}
POLICY
}

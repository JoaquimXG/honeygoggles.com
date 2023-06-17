# General
region = "eu-west-2"

default_tags = {
  project = "tinysite"
  env     = "prod"
}

# Site
site_s3_origin_id = "S3 Origin"

site_bucket_name = "xjg.prod.tinysite"

site_domain = "honeygoggles.com"

site_subdomain = ""

certificate_id = "arn:aws:acm:us-east-1:479916576255:certificate/b8583976-b238-4606-ae9f-ff00b792c9f5"

use_www = true


# Media bucket
DEPLOY_MEDIA_BUCKET = true

media_bucket_name = "xjg.prod.tinysite.media"

media_domain = "honeygoggles.com"

media_subdomain = "media"

media_s3_origin_id = "Media S3 Origin"
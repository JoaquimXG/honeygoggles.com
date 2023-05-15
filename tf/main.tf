terraform {
  backend "s3" {
    bucket         = "xjg.terraformstate"
    key            = "tinysite.tfstate"
    region         = "eu-west-2"
    dynamodb_table = "terraform-state"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.24.0"
    }
  }
}

provider "aws" {
  # profile = "personal" # Profile no longer set in v4.0.0, use env vars instead
  region = var.region

  default_tags {
    tags = var.default_tags
  }

  # assume_role {
  #   role_arn     = "arn:aws:iam::261567139318:role/xjg-admin-cross-account-role"
  #   session_name = "admin"
  # }
}

# S3 Bucket and CloudFront distribution
module "site" {
  source = "./s3-site"

  bucket_tags       = var.site_bucket_tags
  distribution_tags = var.site_distribution_tags

  dns = {
    domain    = var.site_domain
    subdomain = var.site_subdomain
  }

  bucket_name  = var.site_bucket_name
  s3_origin_id = var.site_s3_origin_id
  acm_cert_id  = var.certificate_id
  use_www      = var.use_www
}

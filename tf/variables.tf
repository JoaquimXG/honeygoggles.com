# General
variable "region" {
  type        = string
  description = "AWS region"
}

variable "default_tags" {
  type        = map(string)
  description = "Default tags to apply to all resources"
  default     = {}
}

# Site Bucket and Cert
variable "site_bucket_tags" {
  type        = map(string)
  description = "Tags to apply to the site bucket"
  default     = {}
}

variable "site_distribution_tags" {
  type        = map(string)
  description = "Tags to apply to the site distribution"
  default     = {}
}

variable "site_s3_origin_id" {
  type        = string
  description = "A unique identifier for the origin linking CloudFront and S3. (Just a name, can be any string)"
}

variable "site_bucket_name" {
  type        = string
  description = "Bucket name for site bucket"
}

variable "site_domain" {
  type        = string
  description = "Root domain for site . Must be managed in AWS Route53"
}

variable "site_subdomain" {
  type        = string
  description = "Subdomain for the site bucket"
}

variable "certificate_id" {
  type        = string
  description = "ACM certfiicate ID for certificate matching given domain"
}

variable "use_www" {
  type = bool
  default = true
  description = "If true, use www.domain as an additional cloudfront alias. This should be avoided if the certificate used does not cover the www domain"
}

locals {
  # full_domain = "${var.dns.subdomain == "" ? var.dns.domain : "${var.dns.subdomain}."}${var.dns.domain}"
  full_domain = "${var.dns.subdomain == "" ? var.dns.domain : var.dns.subdomain + "." + var.dns.domain}"
  redirect_origin_id = "${var.s3_origin_id}-redirect"
}

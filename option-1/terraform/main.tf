variable "domain_name" {
  default = "segfaultlabs.com"
}

variable "hosted_zone_id" {
  default = "Z01859851N1KBJ7U68XQM"
}

locals {
  sendgrid_cname_records = [
    {
      host  = "em9025"
      value = "u52536322.wl073.sendgrid.net"
    },
    {
      host  = "s1._domainkey"
      value = "s1.domainkey.u52536322.wl073.sendgrid.net"
    },
    {
      host  = "s2._domainkey"
      value = "s2.domainkey.u52536322.wl073.sendgrid.net"
    }
  ]

  sendgrid_txt_records = [
    {
      host  = "_dmarc"
      value = "v=DMARC1; p=none;"
    }
  ]
}

# CNAME Records
resource "aws_route53_record" "sendgrid_cnames" {
  for_each = {
    for record in local.sendgrid_cname_records :
    "${record.host}" => record
  }

  zone_id = var.hosted_zone_id
  name    = "${each.value.host}"
  type    = "CNAME"
  ttl     = 300
  records = [each.value.value]
}

# TXT Records
resource "aws_route53_record" "sendgrid_txt" {
  for_each = {
    for record in local.sendgrid_txt_records :
    "${record.host}" => record
  }

  zone_id = var.hosted_zone_id
  name    = "${each.value.host}"
  type    = "TXT"
  ttl     = 300
  records = ["${each.value.value}"]
}

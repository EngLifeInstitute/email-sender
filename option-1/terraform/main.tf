variable "domain_name" {
  default = "example.com"
}

variable "hosted_zone_id" {
  default = ""
}

locals {
  sendgrid_cname_records = [
    {
      host  = ""
      value = ""
    },
    {
      host  = ""
      value = ""
    },
    {
      host  = ""
      value = ""
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

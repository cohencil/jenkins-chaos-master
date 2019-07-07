data "aws_route53_zone" "primary" {
  name = var.domain
}

resource "aws_route53_record" "chaos_jenkins" {

  zone_id = data.aws_route53_zone.primary.zone_id
  name    = terraform.workspace
  type    = "A"
  ttl     = "300"
  records = [data.aws_eip.eip.public_ip]
}
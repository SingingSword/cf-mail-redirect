resource "cloudflare_email_routing_rule" "spazzatura_rule" {
  zone_id = var.cloudflare_zone_id
  name = "garbage-redirect"

  actions = [{
    type = "forward"
    value = [cloudflare_email_routing_address.spazzatura_address.email]
  }]
  matchers = [{
    field = "to"
    type = "literal"
    value = "spazzatura@${var.domain}"
  }]

  priority = 0
  enabled = true
}

resource "cloudflare_email_routing_address" "spazzatura_address" {
  account_id = var.cloudflare_account_id
  email = "brambrilliantwork+spazzatura@gmail.com"
}
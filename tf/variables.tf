# Cloudflare ariables
variable "cloudflare_zone_id" {
    description = "zone id for cloudflare"
    nullable = false
    sensitive = true
    type = string
}

variable "cloudflare_account_id" {
    description = "account id for cloudflare"
    nullable = false
    sensitive = true
    type = string
}

variable "domain" {
    description = "DNS domain"
    nullable = false
    sensitive = false
    type = string
}

variable "cloudflare_api_token" {
    description = "API token for cloudflare"
    nullable = false
    sensitive = true
    type = string
}

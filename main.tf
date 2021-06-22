terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "2.19.2"
    }
  }
  
  backend "remote" {
    organization = "sreyo23"

    workspaces {
      name = "cloudflare_git"
    }
  }
}  

variable "site_domain" {
  type        = string
  description = "The domain name to use for the static site"
}

data "cloudflare_zones" "domain" {
  filter {
    name = var.site_domain
  }
}

resource "cloudflare_record" "site_a" {
  zone_id = data.cloudflare_zones.domain.zones[0].id
  name    = "neethu"
  value   = "34.134.131.200"
  type    = "A"

  ttl     = 1
  proxied = true
}


# resource "cloudflare_record" "www" {
#   zone_id = data.cloudflare_zones.domain.zones[0].id
#   name    = "www"
#   value   = var.site_domain
#   type    = "CNAME"

#   ttl     = 1
#   proxied = true
# }

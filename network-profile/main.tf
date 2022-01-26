terraform {
  required_providers {
    vra = {
      source = "vmware/vra"
    }
  }
}

provider "vra" {
  url           = var.url
  refresh_token = var.refresh_token
  insecure      = var.insecure
}

data "vra_region" "this" {
  filter = "name eq 'SPACE-DC'"
}

data "vra_fabric_network" "this" {
  filter = "name eq 'DEVNET02' and externalId eq 'DEVNET02'"
}

data "vra_network_domain" "this" {
  filter = "name eq 'nsx-overlay-transportzone'"
}

resource "vra_network_profile" "newsubnet"{
  name = "newsubnet"
  region_id = data.vra_region.this.id

  isolation_type = "SUBNET"
  isolated_network_cidr_prefix = "28"
  isolated_network_domain_cidr = "172.20.6.0/24"
  isolated_network_domain_id = data.vra_network_domain.this.id
  isolated_external_fabric_network_id = data.vra_fabric_network.this.id
  custom_properties = {
    distributedLogicalRouterStateLink = "T0-ROUTER"
    onDemandNetworkIPAssignmentType = "STATIC"
  }
  tags {
    key = "network"
    value = "newsubnet"
  }
}

output "network-profile-tag" {
  value = [for tags in vra_network_profile.newsubnet.tags : join(":",[tags.key,tags.value])]
}

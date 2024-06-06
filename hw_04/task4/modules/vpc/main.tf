terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

resource "yandex_vpc_network" "netology" {
  name = var.env_name
}

resource "yandex_vpc_subnet" "netology" {

  for_each = { for i in var.subnets : i.zone => i }

  name           = "${var.env_name}-subnet-${each.value.zone}"
  zone           = each.value.zone
  network_id     = yandex_vpc_network.netology.id
  v4_cidr_blocks = [each.value.cidr]
}

terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

resource "yandex_mdb_mysql_cluster" "test_cluster" {
  name                = var.name
  environment         = var.environment
  network_id          = var.network_id
  version             = var.ver

  resources {
    resource_preset_id = var.resources.host.resource_preset_id
    disk_type_id       = var.resources.host.disk_type_id
    disk_size          = var.resources.host.disk_size
  }

  dynamic "host" {
    for_each = var.HA ? {1:"ru-central1-a",2:"ru-central1-a"} : {1:"ru-central1-a"}
    content {
      zone             = host.value
      subnet_id        = var.subnet_id
      assign_public_ip = false
    }
  }
}


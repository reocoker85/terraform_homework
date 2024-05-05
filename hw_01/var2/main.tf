variable "yandex_cloud_token" {
  description = "Yandex_cloud_token"
  type        = string
  sensitive   = true
}

variable "cloud_id" {
  description = "Cloud_id"
  type        = string
  sensitive   = true
}

variable "folder_id" {
  description = "Folder_id"
  type        = string
  sensitive   = true
}

terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 1.00"
}

provider "yandex" {
  token     = var.yandex_cloud_token
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = "ru-central1-a"
}
data "yandex_compute_image" "container-optimized-image" {
  family = "container-optimized-image"
}


resource "random_password" "root_pass" {
  length      = 16
  special     = false
  min_upper   = 1
  min_lower   = 1
  min_numeric = 1
}

resource "random_password" "user_pass" {
  length      = 16
  special     = false
  min_upper   = 1
  min_lower   = 1
  min_numeric = 1
}


resource "yandex_compute_instance" "instance-based-on-coi" {
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.container-optimized-image.id
    }
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-a.id
    nat = true
  }
  resources {
    cores = 2
    memory = 4
    core_fraction = 20
  } 
  scheduling_policy {
    preemptible = true
  }
  metadata = {
    docker-compose = file("./compose.yaml")
    user-data = file("./meta.txt")
  }
}

resource "yandex_vpc_network" "devops-network" {
  name = "devops-network"
}

resource "yandex_vpc_subnet" "subnet-a" {
  name           = "subnet-a"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.devops-network.id
  v4_cidr_blocks = ["192.168.10.0/28"]
}


output "external_ip" {
  value = yandex_compute_instance.instance-based-on-coi.network_interface.0.nat_ip_address
}

